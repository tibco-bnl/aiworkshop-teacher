# Open WebUI Helm Chart - AKS Installation Guide

This guide provides step-by-step instructions for installing Open WebUI on Azure Kubernetes Service (AKS).

## Overview

Open WebUI is an extensible, feature-rich, and user-friendly self-hosted web interface designed to operate entirely offline. It supports various LLM runners, including Ollama and OpenAI-compatible APIs.

### Architecture Components

The deployment consists of three main pods:

1. **open-webui** (Main Application)
   - The core web interface that users interact with
   - Provides the chat interface, model management, and user authentication
   - Includes ChromaDB for vector storage and semantic search capabilities
   - Handles document processing, RAG (Retrieval-Augmented Generation), and conversation history
   - Runs on port 8080 internally
   - Stores persistent data including user configurations, chat history, and uploaded documents

2. **open-webui-pipelines** (Extension Framework)
   - Extends Open WebUI functionality through custom pipelines
   - Allows integration with external services and custom processing logic
   - Enables advanced workflows like custom LLM integrations, data transformations, and API extensions
   - Acts as a middleware layer between Open WebUI and external services
   - Runs on port 9099 internally

3. **open-webui-redis** (WebSocket Manager)
   - Manages real-time WebSocket connections for live features
   - Enables real-time updates, collaborative features, and instant notifications
   - Handles session management and caching for improved performance
   - Essential for multi-user environments and live chat features
   - Runs on port 6379 internally

### Deployment Details

- **Namespace**: `ai`
- **Domain**: `openwebui.your-domain.com`
- **Storage**: Azure Managed CSI (10GB persistent volume)
- **Ingress Controller**: NGINX

## Prerequisites

- Azure Kubernetes Service (AKS) cluster up and running
- `kubectl` configured to access your AKS cluster
- Helm 3.x installed
- (Optional) NGINX Ingress Controller installed if using ingress
- (Optional) cert-manager for automatic TLS certificate management

## Quick Start

### 1. Verify AKS Cluster Access

```bash
# Check cluster connection
kubectl cluster-info

# Verify nodes are ready
kubectl get nodes
```

### 2. Create Namespace

```bash
kubectl create namespace ai
```

### 3. Add Helm Repository (if using remote chart)

If the chart is published to a Helm repository:

```bash
helm repo add open-webui https://helm.openwebui.com
helm repo update
```

### 4. Install Open WebUI

#### Option A: Install from local chart with AKS values

```bash
# Navigate to the helm chart directory
cd /Users/kul/git/ai/open-webui-helm-charts

# Install with AKS-specific values
helm install open-webui ./charts/open-webui \
  --namespace ai \
  --values /Users/kul/git/ai/open-webui-kb/values-aks.yaml
```

#### Option B: Customize installation

Create a custom values file or override specific values:

```bash
helm install open-webui ./charts/open-webui \
  --namespace ai \
  --values /Users/kul/git/ai/open-webui-kb/values-aks.yaml \
  --set ingress.host=your-domain.com \
  --set resources.requests.memory=1Gi
```

### 5. Verify Installation

```bash
# Check pod status
kubectl get pods -n ai

# Check services
kubectl get svc -n ai

# Check ingress (if enabled)
kubectl get ingress -n ai

# View deployment logs
kubectl logs -n ai deployment/open-webui -f
```

### 6. Access Open WebUI

Open WebUI is now accessible at: **`https://openwebui.your-domain.com`**

#### Alternative Access Methods:

**If using port-forward (for testing):**
```bash
kubectl port-forward -n ai svc/open-webui 8080:80
```
Then access at: `http://localhost:8080`

**If using LoadBalancer service:**
```bash
kubectl get svc -n ai open-webui
# Use the EXTERNAL-IP shown
```

### 7. Initial Setup

#### First Login and Admin User Creation

1. Navigate to `https://openwebui.your-domain.com`
2. On first access, you'll see a sign-up page
3. Create the admin account:
   - **Username**: `admin` (or your preferred admin username)
   - **Email**: Your email address
   - **Password**: Choose a strong password
   - **Confirm Password**: Re-enter the password
4. Click "Sign up" to create your account
5. The first user to sign up automatically becomes the admin

**Note**: The first user created has administrative privileges. Subsequent users will have standard user permissions unless promoted by an admin.

#### Configure Ollama Connection

After logging in with your admin account:

1. Click on your profile icon (top right) → **Settings**
2. Navigate to **Admin Panel** → **Connections**
3. In the **Ollama API** section, add your Ollama server URL:
   - **Base URL**: `http://your-ollama-server:11434/v1`
   - Example: `http://ollama.example.com:11434/v1`
4. Click **Save** to apply the changes
5. The system will verify the connection to your Ollama instance

**Important Notes:**
- Ensure your Ollama server is accessible from the AKS cluster
- If Ollama is running in the same Kubernetes cluster, use the service name: `http://ollama-service.namespace.svc.cluster.local:11434/v1`
- If using an external Ollama server, ensure network connectivity and firewall rules allow access

#### Verify Model Availability

1. Go to **Settings** → **Models**
2. You should see the models available from your Ollama server
3. If models don't appear, check:
   - Ollama server connectivity
   - Ollama server has models pulled/available
   - Check pod logs: `kubectl logs -n ai statefulset/open-webui`

### 8. Expected Pod Status

After successful installation, you should see:

```bash
$ kubectl get pods -n ai
NAME                                   READY   STATUS    RESTARTS   AGE
open-webui-0                           1/1     Running   0          15m
open-webui-pipelines-87744c5fc-4469q   1/1     Running   0          15m
open-webui-redis-d44dd866f-crp7s       1/1     Running   0          15m
```

All three pods should be in `Running` status with `1/1` ready.

## Configuration

### AKS-Specific Values

The `values-aks.yaml` file includes AKS-optimized configurations:

- **Storage**: Uses `managed-csi` storage class (Azure Disk)
- **Ingress**: Configured for NGINX Ingress Controller
- **Resources**: Balanced requests and limits for cost-effectiveness
- **Security**: Pod security contexts and read-only root filesystem where applicable
- **High Availability**: Health probes configured for automatic recovery

### Important Configuration Options

#### 1. Ingress Configuration

Edit `values-aks.yaml` or override during installation:

```yaml
ingress:
  enabled: true
  class: "nginx"  # or "azure/application-gateway" for AGIC
  host: "open-webui.yourdomain.com"
  tls: true
```

#### 2. Storage Configuration

```yaml
persistence:
  enabled: true
  storageClass: "managed-csi"  # Azure Disk
  size: 10Gi
```

For Azure Files (if you need ReadWriteMany):
```yaml
persistence:
  enabled: true
  storageClass: "azurefile-csi"
  size: 10Gi
  accessModes:
    - ReadWriteMany
```

#### 3. Azure OpenAI Integration

Add environment variables for Azure OpenAI:

```yaml
extraEnvVars:
  - name: AZURE_OPENAI_API_KEY
    valueFrom:
      secretKeyRef:
        name: azure-openai-secret
        key: api-key
  - name: AZURE_OPENAI_ENDPOINT
    value: "https://your-resource.openai.azure.com/"
```

First, create the secret:
```bash
kubectl create secret generic azure-openai-secret \
  --from-literal=api-key='your-api-key' \
  -n ai
```

#### 4. Resource Scaling

For production workloads, adjust resources:

```yaml
resources:
  requests:
    memory: "1Gi"
    cpu: "1000m"
  limits:
    memory: "4Gi"
    cpu: "4000m"
```

And scale replicas:
```yaml
replicaCount: 3
```

## Setting Up Ingress

### Option 1: NGINX Ingress Controller

1. Install NGINX Ingress Controller:
```bash
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update

helm install ingress-nginx ingress-nginx/ingress-nginx \
  --namespace ingress-nginx \
  --create-namespace \
  --set controller.service.annotations."service\.beta\.kubernetes\.io/azure-load-balancer-health-probe-request-path"=/healthz
```

2. Update DNS to point to the ingress external IP:
```bash
kubectl get svc -n ingress-nginx ingress-nginx-controller
```

### Option 2: Application Gateway Ingress Controller (AGIC)

If using AGIC with AKS, update the ingress class:

```yaml
ingress:
  class: "azure/application-gateway"
  annotations:
    appgw.ingress.kubernetes.io/ssl-redirect: "true"
```

## TLS/SSL Certificate Management

### Using cert-manager with Let's Encrypt

1. Install cert-manager:
```bash
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.13.0/cert-manager.yaml
```

2. Create ClusterIssuer:
```bash
cat <<EOF | kubectl apply -f -
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: letsencrypt-prod
spec:
  acme:
    server: https://acme-v02.api.letsencrypt.org/directory
    email: your-email@example.com
    privateKeySecretRef:
      name: letsencrypt-prod
    solvers:
    - http01:
        ingress:
          class: nginx
EOF
```

3. Update ingress annotations:
```yaml
ingress:
  annotations:
    cert-manager.io/cluster-issuer: "letsencrypt-prod"
  tls: true
```

## Upgrading

```bash
# Upgrade with new values
helm upgrade open-webui ./charts/open-webui \
  --namespace ai \
  --values /Users/kul/git/ai/open-webui-kb/values-aks.yaml

# View upgrade history
helm history open-webui -n ai
```

## Rollback

```bash
# Rollback to previous version
helm rollback open-webui -n ai

# Rollback to specific revision
helm rollback open-webui 1 -n ai
```

## Uninstalling

```bash
# Uninstall the release
helm uninstall open-webui -n ai

# Optionally delete the namespace
kubectl delete namespace ai
```

## User Management

### Managing Users (Admin)

As an admin, you can manage users through the Admin Panel:

1. Go to **Settings** → **Admin Panel** → **Users**
2. View all registered users
3. Promote users to admin or revoke admin privileges
4. Delete users if needed
5. Monitor user activity and settings

### User Roles

- **Admin**: Full access to all features, settings, and user management
- **User**: Standard access to chat, models, and personal settings

## Troubleshooting

### Check Pod Status
```bash
kubectl get pods -n ai
kubectl describe pod <pod-name> -n ai
kubectl logs <pod-name> -n ai

# Check specific pod logs
kubectl logs open-webui-0 -n ai
kubectl logs deployment/open-webui-pipelines -n ai
kubectl logs deployment/open-webui-redis -n ai
```

### Check Persistent Volume Claims
```bash
kubectl get pvc -n ai
kubectl describe pvc open-webui -n ai

# Check PV status
kubectl get pv | grep open-webui
```

### Check Ingress and Connectivity
```bash
kubectl get ingress -n ai
kubectl describe ingress open-webui -n ai

# Test ingress from within cluster
kubectl run -it --rm debug --image=curlimages/curl --restart=Never -- \
  curl http://open-webui.ai.svc.cluster.local
```

### Common Issues

1. **Pod stuck in Pending**: Check PVC binding and node resources
   ```bash
   kubectl describe pod open-webui-0 -n ai
   kubectl get pvc -n ai
   kubectl get nodes
   ```

2. **Ingress not working**: Verify ingress controller is installed and DNS is configured
   ```bash
   kubectl get pods -n ingress-system
   kubectl get svc -n ingress-system
   
   # Check ingress controller logs
   kubectl logs -n ingress-system -l app.kubernetes.io/component=controller
   ```

3. **Storage issues**: Verify storage class exists and PVC is bound
   ```bash
   kubectl get storageclass
   kubectl describe pvc open-webui -n ai
   ```

4. **Permission denied errors**: Check security context settings
   ```bash
   kubectl describe pod open-webui-0 -n ai | grep -A 10 "Security Context"
   ```

5. **Cannot connect to Ollama**: Verify network connectivity
   ```bash
   # From within the pod
   kubectl exec -it open-webui-0 -n ai -- curl http://your-ollama-server:11434/api/tags
   ```

6. **WebSocket issues**: Check Redis connectivity
   ```bash
   kubectl logs deployment/open-webui-redis -n ai
   kubectl exec -it open-webui-0 -n ai -- nc -zv open-webui-redis 6379
   ```

### Viewing All Logs

```bash
# Follow logs from all pods
kubectl logs -f statefulset/open-webui -n ai
kubectl logs -f deployment/open-webui-pipelines -n ai
kubectl logs -f deployment/open-webui-redis -n ai

# View recent logs (last 100 lines)
kubectl logs --tail=100 open-webui-0 -n ai
```

## Security Considerations

### Current Security Configuration

The AKS deployment includes the following security measures:

1. **Non-root execution**: All containers run as user 1000 (non-root)
2. **Capability dropping**: All unnecessary Linux capabilities are dropped
3. **No privilege escalation**: `allowPrivilegeEscalation` is set to false
4. **seccomp profile**: Runtime/Default seccomp profile for syscall filtering
5. **fsGroup**: Proper file system group permissions (1000)

### Secret Management

- **WEBUI_SECRET_KEY**: Currently set via environment variable. For production, consider using:
  ```bash
  # Create a Kubernetes secret
  kubectl create secret generic open-webui-secret \
    --from-literal=secret-key='your-random-generated-key' \
    -n ai
  
  # Update values.yaml to reference the secret
  extraEnvVars:
    - name: WEBUI_SECRET_KEY
      valueFrom:
        secretKeyRef:
          name: open-webui-secret
          key: secret-key
  ```

### Network Security

- **Ingress**: TLS enabled (configure cert-manager for automatic certificates)
- **Internal communication**: All pods communicate within the cluster network
- **WebSocket**: Secured through Redis with internal cluster DNS

### Recommendations for Production

1. **Enable Network Policies**: Restrict pod-to-pod communication
2. **Use cert-manager**: Automate TLS certificate management with Let's Encrypt
3. **Azure Key Vault**: Store sensitive credentials (API keys, secrets)
4. **Pod Security Standards**: Apply restricted pod security standards
5. **Regular Updates**: Keep Open WebUI and dependencies updated
6. **Backup Strategy**: Regularly backup the persistent volume containing user data

## Performance Tuning

### Resource Optimization

Current resource allocation:
- **Open WebUI**: 500m CPU / 512Mi RAM (requests), 2 CPU / 2Gi RAM (limits)
- **Pipelines**: Default resources
- **Redis**: 100m CPU / 256Mi RAM (requests), 500m CPU / 512Mi RAM (limits)

For high-traffic environments, consider:
```yaml
resources:
  requests:
    memory: "1Gi"
    cpu: "1"
  limits:
    memory: "4Gi"
    cpu: "4"

replicaCount: 3  # Scale horizontally
```

### Storage Performance

- **Azure Managed Disks (managed-csi)**: Good for most workloads
- **Premium SSD**: For better I/O performance
- **Azure Files (azurefile-csi)**: If you need ReadWriteMany for multiple replicas

## Backup and Restore

### Backing Up Data

```bash
# Create a backup of the persistent volume
kubectl get pvc -n ai open-webui -o yaml > pvc-backup.yaml

# Export data (if needed)
kubectl exec -n ai open-webui-0 -- tar czf - /app/backend/data > openwebui-backup.tar.gz
```

### Restore Data

```bash
# Copy backup to pod
kubectl cp openwebui-backup.tar.gz ai/open-webui-0:/tmp/

# Extract in pod
kubectl exec -n ai open-webui-0 -- tar xzf /tmp/openwebui-backup.tar.gz -C /
```

## Monitoring and Observability

### Metrics and Logs

```bash
# View resource usage
kubectl top pods -n ai

# Stream logs
kubectl logs -f statefulset/open-webui -n ai

# Export logs for analysis
kubectl logs open-webui-0 -n ai --since=24h > open-webui.log
```

### Health Checks

The deployment includes:
- **Liveness Probe**: Checks if the application is alive (restarts if failing)
- **Readiness Probe**: Ensures pod is ready to receive traffic
- **Startup Probe**: Allows time for application initialization

## Additional Resources

- [Open WebUI Documentation](https://docs.openwebui.com/)
- [Open WebUI GitHub](https://github.com/open-webui/open-webui)
- [Open WebUI Helm Chart Repository](https://github.com/open-webui/helm-charts)
- [AKS Documentation](https://docs.microsoft.com/en-us/azure/aks/)
- [Helm Documentation](https://helm.sh/docs/)
- [NGINX Ingress Controller](https://kubernetes.github.io/ingress-nginx/)
- [cert-manager Documentation](https://cert-manager.io/docs/)

## Support

For issues specific to:
- **Open WebUI**: [GitHub Issues](https://github.com/open-webui/open-webui/issues)
- **Helm Chart**: [Helm Chart Issues](https://github.com/open-webui/helm-charts/issues)
- **AKS**: [Azure Support](https://azure.microsoft.com/en-us/support/)

## Changelog

### Latest Deployment
- **Date**: December 17, 2025
- **Version**: Open WebUI v0.6.41, Chart v8.19.0
- **Deployment**: AKS cluster in Azure
- **URL**: https://openwebui.your-domain.com
- **Key Features**:
  - WebSocket support enabled with Redis
  - Pipelines enabled for extensibility
  - Secure configuration with non-root execution
  - NGINX ingress with TLS
  - Azure Managed Disk storage (10GB)
  - Admin user configured with Ollama connection

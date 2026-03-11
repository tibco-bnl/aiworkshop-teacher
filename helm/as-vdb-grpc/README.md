# AS Vector Database gRPC Services Helm Chart

This Helm chart deploys the TIBCO ActiveSpaces Vector Database gRPC services on a Kubernetes cluster.

## Prerequisites

- Kubernetes 1.19+
- Helm 3.2.0+
- A persistent volume provisioner (if persistence is enabled)
- Nginx ingress controller (if ingress is enabled)

## Installation

### 0. Install Nginx Ingress Controller (if using ingress)

If you plan to use ingress (recommended for production), install the nginx ingress controller first:

```bash
# Install nginx ingress controller
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
helm install ingress-nginx ingress-nginx/ingress-nginx \
  --namespace ingress-nginx \
  --create-namespace
```

Wait for the controller to be ready:
```bash
kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=120s
```

### 1. Add Required Configuration

Before installing the chart, you need to configure the following values in your `values-aks.yaml` or using `--set` flags:

Copy a license file into the `files/license_key/` directory and configure it below.

```yaml
# Required: Set the appropriate image tags
global:
  namespace: workshop-ia
  createNamespace: true
  imageRegistry: ghcr.io/mbloomfi-tibco
  asVersion: "5.0.0"  # Replace with your AS version
  grpcServicesVersion: "0.0.5"  # Replace with your gRPC services version

# Core DNS name for ingress hosts
coreDnsName: "example.com"  # Replace with your domain

# Required: Configure FTL server
ftlserver:
  command:
    licenseServerUrl: "file:///config/AS-VECTORDB_ANY.bin"  # Use license file
    configPath: /config/ftl-dev.yaml
    name: ftl0
  config:
    ftlDevYaml: "files/config/ftl-dev.yaml"
    licenseKeyFile: "files/license_key/AS-VECTORDB_ANY.bin"

# Required: Configure TIBDG
config:
  tibdgConfig: "files/config/conf-dev.tibdg"

# Optional: Enable ingress
ingress:
  enabled: false  # Set to true to enable
  className: "nginx"
  whitelistSourceRanges: []  # Add IP ranges for access control
    # - "192.168.1.0/24"
```

### 2. Install the Chart

```bash
# Install with default values (you'll need to customize them)
helm install as-vdb-grpc .

# Install with custom values file
helm install as-vdb-grpc . -f values.yaml

# Install with AKS optimized values
helm install as-vdb-grpc . -f values-aks.yaml

# Install with example values (for development)
helm install as-vdb-grpc . -f values-example.yaml

# Install with command line overrides
helm install as-vdb-grpc . \
  --set global.asVersion=5.0.0 \
  --set global.grpcServicesVersion=0.0.5 \
  --set coreDnsName=example.com
```

### 3. Access the Services

After installation, the services will be available at (ClusterIP by default):

- **VectorStore gRPC**: `<release-name>-vectorstore:50051`
- **DocumentStore gRPC**: `<release-name>-documentstore:50052`
- **FTL Server**: `<release-name>-ftlserver:13031`

#### Via Ingress (Recommended)

Enable ingress for external access:

```yaml
ingress:
  enabled: true
  className: "nginx"
  ## Hostnames will be: <service-host>.<coreDnsName>
  ftlserver:
    host: ftlserver  # Results in ftlserver.example.com
  vectorstore:
    host: vectorstore  # Results in vectorstore.example.com
  documentstore:
    host: documentstore  # Results in documentstore.example.com
```

#### Via LoadBalancer/NodePort

Alternatively, change service types for direct access:

```yaml
ftlserver:
  service:
    type: LoadBalancer  # or NodePort
vectorstore:
  service:
    type: LoadBalancer  # or NodePort
documentstore:
  service:
    type: LoadBalancer  # or NodePort
```

## Configuration

### Values Files

The chart includes three preconfigured values files:

- `values.yaml` - Default configuration with ClusterIP services
- `values-aks.yaml` - AKS optimized with ingress and IP whitelisting
- `values-example.yaml` - Example configuration with detailed comments

### Global Settings

| Parameter | Description | Default |
|-----------|-------------|---------|  
| `global.namespace` | Target namespace for deployment | `workshop-ia` |
| `global.createNamespace` | Create namespace if it doesn't exist | `true` |
| `global.imageRegistry` | Docker registry for all images | `ghcr.io/mbloomfi-tibco` |
| `global.asVersion` | AS version tag | `5.0.0` |
| `global.grpcServicesVersion` | gRPC services version tag | `0.0.5` |
| `coreDnsName` | Core DNS name for ingress hosts | `example.com` |

| Parameter | Description | Default |
|-----------|-------------|---------| 
| `ftlserver.enabled` | Enable FTL server | `true` |
| `ftlserver.image.repository` | Image repository | `as-tibftlserver` |
| `ftlserver.service.type` | Service type | `ClusterIP` |
| `ftlserver.service.port` | Service port | `13031` |
| `ftlserver.command.configPath` | Config file path | `/config/ftl-dev.yaml` |
| `ftlserver.command.name` | FTL server name | `ftl0` |
| `ftlserver.command.licenseServerUrl` | License server URL | `file:///config/AS-VECTORDB_ANY.bin` |
| `ftlserver.config.ftlDevYaml` | FTL config file path | `files/config/ftl-dev.yaml` |
| `ftlserver.config.licenseKeyFile` | License key file path | `files/license_key/AS-VECTORDB_ANY.bin` |
| `ftlserver.resources.limits.memory` | Memory limit | `4Gi` |
| `ftlserver.resources.requests.memory` | Memory request | `1Gi` |
| Parameter | Description | Default |
|-----------|-------------|---------|
| `vectorstore.enabled` | Enable vector store service | `true` |
| `vectorstore.image.repository` | Image repository | `tib-as-vectorstore` |
| `vectorstore.service.port` | Service port | `50051` |
| `vectorstore.environment.asConnUrl` | AS connection URL | `http://ftlserver-0:13031` |

### Document Store Settings

| Parameter | Description | Default |
|-----------|-------------|---------|
| `documentstore.enabled` | Enable document store service | `true` |
| `documentstore.image.repository` | Image repository | `tib-as-documentstore` |
| `documentstore.service.type` | Service type | `ClusterIP` |
| `documentstore.service.port` | Service port | `50052` |
| `documentstore.environment.asConnUrl` | AS connection URL | `http://as-vdb-grpc-ftlserver:13031` |
| `config.tibdgConfig` | TIBDG config file path | `files/config/conf-dev.tibdg` |
| `tibdgproxy.enabled` | Enable TIBDG proxy | `true` |
| `tibdgproxy.replicas` | Number of proxy replicas | `1` |
| `tibdgnode.enabled` | Enable TIBDG node | `true` |
| `tibdgnode.replicas` | Number of node replicas | `1` |

### Ingress Settings

| Parameter | Description | Default |
|-----------|-------------|---------|  
| `ingress.enabled` | Enable ingress | `true` |
| `ingress.className` | Ingress class name | `nginx` |
| `ingress.whitelistSourceRanges` | IP ranges for access control | `[]` |
| `ingress.ftlserver.host` | FTL server subdomain | `ftlserver` |
| `ingress.vectorstore.host` | Vector store subdomain | `vectorstore` |
| `ingress.documentstore.host` | Document store subdomain | `documentstore` |

**Note**: Full hostnames are constructed as `<host>.<coreDnsName>`

#### IP Whitelisting

Restrict access to specific IP ranges:

```yaml
ingress:
  whitelistSourceRanges:
    - "192.168.1.0/24"
    - "10.0.0.0/8"
    - "172.16.0.0/12"
```

### Domain Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|  
| `coreDnsName` | Base domain for ingress hostnames | `example.com` |

### Persistence Settings

| Parameter | Description | Default |
|-----------|-------------|---------|
| `persistence.enabled` | Enable persistent volume | `true` |
| `persistence.storageClass` | Storage class | `""` (default) |
| `persistence.accessMode` | Access mode | `ReadWriteMany` |
| `persistence.size` | Volume size | `10Gi` |

## Advanced Configuration

### Complete Ingress Example

```yaml
coreDnsName: "dp1.atsnl-emea.azure.dataplanes.pro"

ingress:
  enabled: true
  className: nginx
  whitelistSourceRanges:
    - "192.168.1.0/24"
    - "10.0.0.0/8"
    - "172.16.0.0/12"
  ftlserver:
    host: ftlserver
  vectorstore:
    host: vectorstore  
  documentstore:
    host: documentstore
```

This creates ingress endpoints at:
- `ftlserver.dp1.atsnl-emea.azure.dataplanes.pro:80`
- `vectorstore.dp1.atsnl-emea.azure.dataplanes.pro:80` 
- `documentstore.dp1.atsnl-emea.azure.dataplanes.pro:80`

### LoadBalancer Services (Alternative to Ingress)

To use LoadBalancer services instead of ingress:

```yaml
ingress:
  enabled: false

ftlserver:
  service:
    type: LoadBalancer
    
vectorstore:
  service:
    type: LoadBalancer
    
documentstore:
  service:
    type: LoadBalancer
```

## Upgrading

```bash
helm upgrade as-vdb-grpc ./helm -f my-values.yaml
```

## Uninstalling

```bash
helm uninstall as-vdb-grpc
```

**Note**: This will not delete persistent volume claims by default. To delete them:

```bash
kubectl delete pvc -l app.kubernetes.io/instance=as-vdb-grpc
```

## Troubleshooting

### Common Issues

1. **Pods stuck in Pending state**: Check if there are sufficient resources and if persistent volume claims can be satisfied.

2. **Services not starting**: Check the logs of the FTL server first, as other services depend on it:
   ```bash
   kubectl logs -l app.kubernetes.io/component=ftlserver
   ```

3. **Init containers failing**: The services use init containers to wait for dependencies. Check their logs:
   ```bash
   kubectl logs <pod-name> -c wait-for-ftlserver
   kubectl logs <pod-name> -c wait-for-config
   ```

4. **Ingress not working**: 
   - Verify nginx ingress controller is installed:
     ```bash
     kubectl get pods -n ingress-nginx
     ```
   - Check ingress resources:
     ```bash
     kubectl get ingress
     kubectl describe ingress as-vdb-grpc-ftlserver
     ```
   - Test if services are reachable internally:
     ```bash
     kubectl port-forward svc/as-vdb-grpc-vectorstore 50051:50051
     ```

5. **IP whitelisting issues**: Check nginx controller logs for rejected requests:
   ```bash
   kubectl logs -n ingress-nginx deployment/ingress-nginx-controller
   ```

### Viewing Logs

```bash
# View all logs
kubectl logs -l app.kubernetes.io/name=as-vdb-grpc

# View specific service logs
kubectl logs -l app.kubernetes.io/component=vectorstore
kubectl logs -l app.kubernetes.io/component=documentstore
kubectl logs -l app.kubernetes.io/component=ftlserver
```

### Testing Connectivity

#### Internal Cluster Testing
```bash
# Test from within cluster
kubectl run test-pod --image=busybox:1.35 --rm -it -- sh
# Then inside the pod:
nc -z as-vdb-grpc-vectorstore 50051
nc -z as-vdb-grpc-documentstore 50052
```

#### Ingress Testing
```bash
# Test ingress endpoints (replace with your domain)
curl -v http://ftlserver.example.com/health
curl -v http://vectorstore.example.com/health  
curl -v http://documentstore.example.com/health

# Test gRPC services through ingress
grpcurl -plaintext ftlserver.example.com:80 list
grpcurl -plaintext vectorstore.example.com:80 list
grpcurl -plaintext documentstore.example.com:80 list
```

#### Port-Forward for Direct Testing
```bash
# Forward ports for direct testing
kubectl port-forward svc/as-vdb-grpc-vectorstore 50051:50051
kubectl port-forward svc/as-vdb-grpc-documentstore 50052:50052
kubectl port-forward svc/as-vdb-grpc-ftlserver 13031:13031
```

## Security Considerations

- The chart includes security contexts with non-root user execution
- Consider using Pod Security Standards in your namespace
- Review and customize the security contexts based on your requirements
- Use proper RBAC and network policies as needed

## Contributing

Please refer to the contriburon guide in the main repository for information on how to contribute to this chart.
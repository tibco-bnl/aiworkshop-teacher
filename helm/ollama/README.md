# Ollama Helm Chart for Kubernetes

Deploy Ollama with CPU-only inference on any Kubernetes cluster - **no GPU required**.

## Quick Deploy

```bash
# Generic Kubernetes cluster
helm install ollama . -f values-cpu-ollama.yaml --namespace ai --create-namespace

# AKS cluster (starts with 0 replicas for cost optimization)
helm install ollama . -f values-aks.yaml --namespace ai --create-namespace
kubectl scale deployment -n ai ai-workshop-ollama --replicas=1
```

## Overview

This Helm chart deploys Ollama for LLM inference using pure CPU processing:
- **Chat Model:** Llama 3.2 (3B parameters)
- **Embedding Model:** Nomic-Embed-Text (768-dim vectors for RAG)
- **Platform:** Any Kubernetes cluster (AKS, EKS, GKE, on-prem)
- **Resources:** 2-4 CPU cores, 4-8 GiB RAM

## Prerequisites

- Any Kubernetes cluster (no GPU required)
- Helm 3.x installed
- kubectl configured to access your cluster

## Installation

### Install with Generic Settings

```bash
# Deploy Ollama with CPU inference
helm install ollama . \
  -f values-cpu-ollama.yaml \
  --namespace ai \
  --create-namespace

# Verify deployment
kubectl get pods -n ai -l app.kubernetes.io/component=ollama-server

# Wait for models to download (2-3 minutes)
kubectl logs -n ai -l app.kubernetes.io/component=ollama-server -c pull-models --follow
```

### Install on AKS (with cost optimization)

```bash
# Deploy with AKS-specific settings (starts with 0 replicas)
helm install ollama . \
  -f values-aks.yaml \
  --namespace ai \
  --create-namespace

# Scale up when ready to use
kubectl scale deployment -n ai ai-workshop-ollama --replicas=1
```

### Test Deployment

```bash
# Run the test script
./test-ollama-embedding.sh

# Or test interactively with a question
kubectl exec -n ai -it deployment/ai-workshop-ollama -- ollama run llama3.2:3b "What is Kubernetes?"

# Or manually test via API
kubectl port-forward -n ai svc/ai-workshop-ollama 11434:80 &

# Test chat model
curl http://localhost:11434/api/generate -d '{
  "model": "llama3.2:3b",
  "prompt": "What is 5+3? Answer with just the number.",
  "stream": false
}'

# Test embeddings
curl http://localhost:11434/api/embeddings -d '{
  "model": "nomic-embed-text",
  "prompt": "Hello world"
}'
```

## Configuration

### Key Parameters

| Parameter | Description | Default |
|-----------|-------------|---------|
| `replicaCount` | Number of pod replicas | `1` |
| `ollama.enabled` | Enable Ollama deployment | `true` |
| `ollama.image.repository` | Ollama image | `ollama/ollama` |
| `ollama.image.tag` | Image tag | `latest` |
| `ollama.models.chat` | Chat models to pre-load | `["llama3.2:3b"]` |
| `ollama.models.embedding` | Embedding models | `["nomic-embed-text"]` |
| `ollama.port` | Service port | `11434` |
| `ollama.resources.requests.cpu` | CPU request | `2` |
| `ollama.resources.requests.memory` | Memory request | `4Gi` |
| `ollama.resources.limits.cpu` | CPU limit | `4` |
| `ollama.resources.limits.memory` | Memory limit | `8Gi` |
| `service.type` | Kubernetes service type | `ClusterIP` |
| `service.ollama.port` | External service port | `80` |
| `service.ollama.targetPort` | Container port | `11434` |
| `storage.ollama.ephemeral` | Use ephemeral storage | `true` |
| `storage.ollama.persistentVolume.enabled` | Use PVC | `false` |

### Customize Models

Edit your values file (e.g., `values-cpu-ollama.yaml`):

```yaml
ollama:
  models:
    chat:
      - "llama3.2:3b"      # Default - 2GB
      # - "llama3.2:1b"    # Smaller - 1GB
      # - "phi3:mini"      # Alternative - 2GB
      # - "llama3.3:latest" # Larger - 43GB
    embedding:
      - "nomic-embed-text" # Default - 274MB
      # - "mxbai-embed-large" # Alternative - 669MB
      # - "all-minilm"     # Smaller - 46MB
```

See [Ollama Library](https://ollama.ai/library) for available models.

### Resource Tuning

**For smaller clusters or lighter models:**
```yaml
ollama:
  resources:
    requests:
      cpu: "1"
      memory: "2Gi"
    limits:
      cpu: "2"
      memory: "4Gi"
```

**For larger models (e.g., 7B or 13B parameters):**
```yaml
ollama:
  resources:
    requests:
      cpu: "4"
      memory: "8Gi"
    limits:
      cpu: "8"
      memory: "16Gi"
```

## Usage Examples

### List Available Models

```bash
kubectl exec -n ai deployment/ai-workshop-ollama -- ollama list
```

### Pull Additional Models

```bash
kubectl exec -n ai deployment/ai-workshop-ollama -- ollama pull phi3:mini
```

### Chat Interactively

Start an interactive chat session with the model:

```bash
kubectl exec -n ai -it deployment/ai-workshop-ollama -- ollama run llama3.2:3b
```

Or ask a single question directly:

```bash
kubectl exec -n ai -it deployment/ai-workshop-ollama -- ollama run llama3.2:3b "Explain what Kubernetes is in one sentence"
```

### Port Forward for Local Access

```bash
# Forward to localhost
kubectl port-forward -n ai svc/ai-workshop-ollama 11434:80

# Now use Ollama CLI locally
export OLLAMA_HOST=http://localhost:11434
ollama list
ollama run llama3.2:3b "Hello!"
```

## Management Operations

### Scale Down (Stop to save costs)

```bash
# Set replicas to 0
kubectl scale deployment -n ai ai-workshop-ollama --replicas=0

# Or use helm
helm upgrade ollama . -f values-aks.yaml --set replicaCount=0 -n ai
```

### Scale Up (Start)

```bash
# Set replicas to 1
kubectl scale deployment -n ai ai-workshop-ollama --replicas=1

# Or use helm
helm upgrade ollama . -f values-aks.yaml --set replicaCount=1 -n ai
```

### Upgrade Chart

```bash
helm upgrade ollama . -f values-cpu-ollama.yaml -n ai
```

### Uninstall

```bash
helm uninstall ollama -n ai
kubectl delete namespace ai
```

## Storage Options

### Ephemeral Storage (Default)
- Models download on each pod start
- Faster pod deletion
- Slower startup (~2-3 minutes for initial model download)
- Good for auto-scaling environments

### Persistent Volume
- Models persist across pod restarts
- Faster startup after first boot
- Uses cluster storage resources

To enable persistent storage, edit your values file:

```yaml
storage:
  ollama:
    enabled: true
    ephemeral: false
    persistentVolume:
      enabled: true
      size: 10Gi
      storageClass: "default"  # Use your cluster's storage class
      mountPath: "/root/.ollama"
```

## Troubleshooting

### Pods Stuck in Pending

```bash
# Check pod status
kubectl describe pod -n ai -l app.kubernetes.io/component=ollama-server
```

**Common causes:**
- Insufficient CPU/memory resources in cluster
- Storage class doesn't exist (if using PVC)
- Node scheduling constraints

**Solution:**
- Reduce resource requests in values file
- Ensure cluster has available resources
- Verify storage class: `kubectl get storageclass`

### Models Not Downloading

```bash
# Check init container logs
kubectl logs -n ai -l app.kubernetes.io/component=ollama-server -c pull-models
```

**Common causes:**
- No internet access from cluster
- Rate limiting from ollama.ai
- Network policies blocking egress

**Solution:**
- Verify cluster has internet access
- Check network policies: `kubectl get networkpolicies -n ai`
- Wait and retry (rate limits are temporary)

### Service Not Responding

```bash
# Check container logs
kubectl logs -n ai -l app.kubernetes.io/component=ollama-server -c ollama

# Verify readiness probe
kubectl get pods -n ai -l app.kubernetes.io/component=ollama-server -o wide
```

**Common causes:**
- Ollama server failed to start
- Readiness probe timeout
- Models not loaded

**Solution:**
- Check logs for errors
- Increase `readinessProbe.initialDelaySeconds` if models are slow to download
- Verify models are present: `kubectl exec -n ai deployment/ai-workshop-ollama -- ollama list`

### Out of Memory (OOMKilled)

```bash
# Check pod events
kubectl describe pod -n ai -l app.kubernetes.io/component=ollama-server
```

**Common causes:**
- Model too large for allocated memory
- Multiple large models loaded simultaneously

**Solution:**
- Increase memory limits in values file
- Use smaller models (e.g., llama3.2:1b instead of :3b)
- Reduce number of models in `ollama.models` list

## Values Files

This chart includes two values files:

| File | Description | Use Case |
|------|-------------|----------|
| `values-cpu-ollama.yaml` | Generic CPU deployment | Any Kubernetes cluster |
| `values-aks.yaml` | AKS-specific with cost controls | Azure AKS production deployment |

### Key Differences

**values-cpu-ollama.yaml:**
- `replicaCount: 1` - Starts immediately
- Generic configuration
- Default resource limits

**values-aks.yaml:**
- `replicaCount: 0` - Starts stopped (cost optimization)
- AKS-specific annotations and labels
- Cluster-specific settings (dp1-aks-aauk-kul)

## Architecture

```
┌─────────────────────────────────────┐
│  Kubernetes Cluster (CPU-only)     │
│                                     │
│  ┌───────────────────────────────┐ │
│  │  Pod: ai-workshop-ollama      │ │
│  │                               │ │
│  │  ┌─────────────────────────┐  │ │
│  │  │ Init: pull-models       │  │ │
│  │  │ - llama3.2:3b          │  │ │
│  │  │ - nomic-embed-text     │  │ │
│  │  └─────────────────────────┘  │ │
│  │                               │ │
│  │  ┌─────────────────────────┐  │ │
│  │  │ Container: ollama       │  │ │
│  │  │ Port: 11434            │  │ │
│  │  │ CPU: 2-4 cores         │  │ │
│  │  │ Memory: 4-8 GiB        │  │ │
│  │  └─────────────────────────┘  │ │
│  └───────────────────────────────┘ │
│               │                     │
│  ┌────────────▼──────────────────┐ │
│  │  Service: ai-workshop-ollama │ │
│  │  Type: ClusterIP             │ │
│  │  Port: 80 → 11434           │ │
│  └──────────────────────────────┘ │
└─────────────────────────────────────┘
```

## Additional Documentation

- **[OLLAMA-DEPLOYMENT-GUIDE.md](OLLAMA-DEPLOYMENT-GUIDE.md)** - Detailed deployment instructions and examples
- **[test-ollama-embedding.sh](test-ollama-embedding.sh)** - Automated testing script

## API Reference

### Chat Completion

```bash
curl http://localhost:11434/api/generate -d '{
  "model": "llama3.2:3b",
  "prompt": "Your question here",
  "stream": false
}'
```

### Embeddings

```bash
curl http://localhost:11434/api/embeddings -d '{
  "model": "nomic-embed-text",
  "prompt": "Text to embed"
}'
```

### List Models

```bash
curl http://localhost:11434/api/tags
```

See [Ollama API Documentation](https://github.com/ollama/ollama/blob/main/docs/api.md) for complete API reference.

## Support

For issues specific to:
- **Ollama:** https://github.com/ollama/ollama
- **This Helm chart:** Create an issue in the repository
- **Kubernetes deployment:** Check troubleshooting section above

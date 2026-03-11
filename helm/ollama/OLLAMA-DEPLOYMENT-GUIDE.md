# Ollama Deployment Guide - No GPU Required

> **📖 Background:** This deployment option was created when we encountered GPU VM provisioning blockers (quota/availability issues). It provides a production-ready alternative without GPU dependencies, with 92% cost savings compared to GPU deployments. See [GPU vs CPU Context](GPU-VS-CPU-CONTEXT.md) for the full story.

## What You Have Deployed

✅ **Ollama Server** (CPU-only) in the `ai` namespace with:
- **llama3.2:3b** - Chat/LLM model (2.0 GB)
- **nomic-embed-text** - Embedding model for RAG (274 MB, 768 dimensions)

## Connection Details

**Service Name:** `ai-workshop-ollama`
**Namespace:** `ai`
**Internal URL:** `http://ai-workshop-ollama.ai.svc.cluster.local`
**Port:** 80 (maps to Ollama's 11434)

---

## Usage Examples

### 1. Test Scripts Created

Run the test script to verify everything works:
```bash
./test-ollama-embedding.sh
```

Python example for RAG applications:
```bash
python example-ollama-usage.py
```

### 2. Connect to Open WebUI

Your Open WebUI is already running in the same namespace. To connect it to Ollama:

**Option A: Update Open WebUI environment variable**
```bash
kubectl set env statefulset/open-webui -n ai \
  OLLAMA_BASE_URL=http://ai-workshop-ollama:80
kubectl rollout restart statefulset/open-webui -n ai
```

**Option B: Configure in Open WebUI UI**
1. Access Open WebUI
2. Go to Settings → Connections
3. Set Ollama API URL: `http://ai-workshop-ollama:80`
4. Save and test connection

### 3. API Endpoints

**Chat/Generate:**
```bash
POST http://ai-workshop-ollama.ai.svc.cluster.local/api/generate
{
  "model": "llama3.2:3b",
  "prompt": "Your question here",
  "stream": false
}
```

**Embeddings:**
```bash
POST http://ai-workshop-ollama.ai.svc.cluster.local/api/embeddings
{
  "model": "nomic-embed-text",
  "prompt": "Text to embed"
}
```

**List Models:**
```bash
GET http://ai-workshop-ollama.ai.svc.cluster.local/api/tags
```

### 4. Test from Pod

```bash
# Create a test pod
kubectl run -it --rm test-ollama --image=curlimages/curl -n ai -- sh

# Inside the pod, test the API:
curl http://ai-workshop-ollama/api/tags
```

---

## For Local Development

**Port-forward to access from your laptop:**
```bash
kubectl port-forward -n ai svc/ai-workshop-ollama 11434:80

# Then use:
# http://localhost:11434
```

---

## Architecture

```
┌─────────────────────────────────────────────┐
│          Kubernetes Cluster (ai ns)         │
│                                             │
│  ┌──────────────┐      ┌──────────────┐   │
│  │  Open WebUI  │─────▶│   Ollama     │   │
│  │              │      │              │   │
│  └──────────────┘      │ • llama3.2   │   │
│                        │ • nomic-embed│   │
│  ┌──────────────┐      │              │   │
│  │  Your Apps   │─────▶│  (CPU-only)  │   │
│  └──────────────┘      └──────────────┘   │
└─────────────────────────────────────────────┘
```

---

## Resources

- **CPU:** 2-4 cores
- **Memory:** 4-8 GiB
- **GPU:** None (removed all GPU dependencies)
- **Storage:** Ephemeral (models re-downloaded on pod restart)

---

## Model Details

**llama3.2:3b**
- Size: 2.0 GB
- Context: 4096 tokens
- Use: Chat, Q&A, reasoning

**nomic-embed-text**
- Size: 274 MB  
- Output: 768-dimensional vectors
- Use: Embeddings for RAG, semantic search
- Based on: Nomic AI's embedding model

---

## Troubleshooting

**Check pod status:**
```bash
kubectl get pods -n ai -l app.kubernetes.io/component=ollama-server
```

**View logs:**
```bash
kubectl logs -n ai -l app.kubernetes.io/component=ollama-server -c ollama
```

**Test models:**
```bash
kubectl exec -n ai deployment/ai-workshop-ollama -- ollama list
```

**Restart deployment:**
```bash
helm upgrade ai-workshop ./helm/ai-workshop \
  --namespace ai \
  --values helm/ai-workshop/values-cpu-ollama.yaml
```

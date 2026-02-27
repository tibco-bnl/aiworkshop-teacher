# AI Workshop - Teacher Setup

Quick deployment guide for setting up the AI Workshop Kubernetes environment.

📦 **[View Releases](https://github.com/tibco-bnl/aiworkshop-teacher/releases)** | Current Version: [v1.0.0](https://github.com/tibco-bnl/aiworkshop-teacher/releases/tag/v1.0.0) | [Release Notes](releases/v1.0.0.md)

## Architecture Overview

The workshop environment consists of:
- **ActiveSpaces**: Document store and vector database for RAG
- **Ollama**: LLM inference (Llama 3.2) and embeddings (Nomic-Embed-Text)
- **Docling**: Document ingestion and processing
- **OpenWebUI**: Optional web interface for testing

All services are exposed via NGINX Ingress with IP whitelisting for security.

## Prerequisites

- Kubernetes cluster (AKS or any K8s cluster)
- `kubectl` configured and connected to your cluster
- `helm` 3.x installed
- NGINX Ingress Controller installed in your cluster

## Quick Start - Deploy All Services

Run these commands in order to set up the complete workshop environment:

### 1. Deploy ActiveSpaces (Document & Vector Database)

```bash
cd helm/as-vdb-grpc
helm install activespaces . -f values-aks.yaml --namespace ai --create-namespace
```

**Endpoints:**
- Document Store: `ai-documentstore.dp1.atsnl-emea.azure.dataplanes.pro:80`
- Vector Store: `ai-vectorstore.dp1.atsnl-emea.azure.dataplanes.pro:80`

### 2. Deploy Ollama (LLM & Embeddings)

```bash
cd helm/ollama
helm install ollama . -f values-aks.yaml --namespace ai --create-namespace
kubectl scale deployment -n ai ai-workshop-ollama --replicas=1
```

**Endpoint:** `ai-ollama.dp1.atsnl-emea.azure.dataplanes.pro:80`

**Models included:**
- Chat: Llama 3.2 (3B)
- Embeddings: Nomic-Embed-Text

### 3. Deploy Docling (Document Processing)

```bash
cd helm/docling
helm install docling . -f values.yaml --namespace ai --create-namespace
```

**Endpoint:** `ai-docling.dp1.atsnl-emea.azure.dataplanes.pro:80`

### 4. Deploy OpenWebUI (Optional - Web Interface)

```bash
cd helm/openwebui
helm install openwebui . -f values-aks.yaml --namespace ai --create-namespace
```

**Endpoint:** `ai-openwebui.dp1.atsnl-emea.azure.dataplanes.pro:80`

## Verify Deployment

Check all pods are running:

```bash
kubectl get pods -n ai
kubectl get ingress -n ai
kubectl get svc -n ai
```

## Connecting to ActiveSpaces with JDBC

You can connect to ActiveSpaces using DBeaver or any JDBC client to inspect and query the document and vector stores.

### DBeaver Configuration

1. **Install ActiveSpaces 5.x** on your local machine

2. **Configure Database Driver:**
   - Add libraries from ActiveSpaces installation:
     - **bin folder**: `tibdgjni.dll` (Windows) or equivalent for your OS
     - **lib folder**: `tibdg.jar`
   - See [JDBC Client Libraries Configuration](images/as-jdbc-client-libraries-config.png)

3. **Connection URL:**
   ```
   jdbc:tibco:tibdg:_default;realmurl=http://localhost:3031
   ```
   For remote connections, replace `localhost:3031` with your ActiveSpaces endpoint.

4. **Configure Connection:**
   - See [JDBC Client Settings Configuration](images/as-jdbc-client-settings-config.png)

Once connected, you can browse tables, run SQL queries, and inspect the stored documents and vectors.

## Running the Workshop Ingestion

Once all services are deployed, you can run the Flogo ingestion flow:

```bash
cd asvectorstore/bin
./ingestsamplefileslocal
```

The ingestion flow uses the following endpoints:
- Document Store: `ai-documentstore.dp1.atsnl-emea.azure.dataplanes.pro:80`
- Vector Store: `ai-vectorstore.dp1.atsnl-emea.azure.dataplanes.pro:80`
- Docling: `ai-docling.dp1.atsnl-emea.azure.dataplanes.pro:80`
- Ollama: `ai-ollama.dp1.atsnl-emea.azure.dataplanes.pro:80`

## Cleanup

Remove all workshop resources:

```bash
helm uninstall activespaces -n ai
helm uninstall ollama -n ai
helm uninstall docling -n ai
helm uninstall openwebui -n ai

# Optional: Delete namespace
kubectl delete namespace ai
```

## Notes

- All ingress endpoints are IP-whitelisted for security
- Ollama starts with 0 replicas on AKS for cost optimization - scale to 1 when needed
- ActiveSpaces requires a valid license file in `helm/as-vdb-grpc/files/license_key/`
- Persistent storage is managed via Azure Files (or your cluster's default storage class)

## Workshop Components

### Document Processing Flow
1. **Docling** processes and extracts content from documents
2. **Ollama** generates embeddings from the extracted content
3. **ActiveSpaces Document Store** stores the original document metadata
4. **ActiveSpaces Vector Store** stores the embeddings for semantic search

### Query Flow
1. User query → **Ollama** (generate query embedding)
2. Vector search → **ActiveSpaces Vector Store** (find similar documents)
3. Retrieve context → **ActiveSpaces Document Store** (get full document content)
4. Generate answer → **Ollama** (LLM with RAG context)

---

**Ready to start your workshop day with a smile! 😊**
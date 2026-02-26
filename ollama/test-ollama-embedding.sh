#!/bin/bash
# Test script for Ollama embedding and chat

NAMESPACE="ai"
SERVICE="ai-workshop-ollama"

echo "🔗 Setting up port-forward to Ollama service..."
kubectl port-forward -n $NAMESPACE svc/$SERVICE 11434:80 &
PF_PID=$!
sleep 2

echo ""
echo "✅ Testing Chat Model (llama3.2:3b)..."
curl -s http://localhost:11434/api/generate -d '{
  "model": "llama3.2:3b",
  "prompt": "What is 5+3? Answer with just the number.",
  "stream": false
}' | jq -r '.response'

echo ""
echo ""
echo "✅ Testing Embedding Model (nomic-embed-text)..."
curl -s http://localhost:11434/api/embeddings -d '{
  "model": "nomic-embed-text",
  "prompt": "Hello world"
}' | jq '.embedding[:10]'

echo ""
echo "📊 Model List:"
curl -s http://localhost:11434/api/tags | jq '.models[] | {name: .name, size: .size}'

# Cleanup
kill $PF_PID 2>/dev/null
echo ""
echo "✅ Done! Port-forward closed."

# Docker Registry Secret Setup

This Helm chart now supports automatic creation of Docker registry secrets for pulling images from private registries.

## Configuration

The docker registry secret is configured in `values.yaml`:

```yaml
dockerRegistry:
  enabled: true
  secretName: ghcr-login-secret  
  server: ghcr.io
```

## Security Setup

1. **Copy the environment template:**
   ```bash
   cp .env.example .env
   ```

2. **Edit `.env` with your credentials:**
   ```bash
   DOCKER_USERNAME=your-username@domain.com
   DOCKER_PASSWORD=your-personal-access-token
   ```

3. **The `.env` file is automatically ignored by git** to prevent credentials from being committed.

## Deployment Options

### Option 1: Using the deployment script (Recommended)
```bash
cd setup/helm/as-vdb-grpc
chmod +x deploy.sh
./deploy.sh
```

### Option 2: Manual deployment with environment variables
```bash
cd setup/helm/as-vdb-grpc
source .env
helm upgrade --install as-vdb-grpc .
```

### Option 3: Disable docker registry secret creation
If you want to manage the secret separately:
```bash
helm upgrade --install as-vdb-grpc . --set dockerRegistry.enabled=false
```

## How It Works

- The chart reads `DOCKER_USERNAME` and `DOCKER_PASSWORD` from environment variables
- Creates a `kubernetes.io/dockerconfigjson` secret automatically
- The secret is referenced in the `serviceAccount.imagePullSecrets` configuration
- All pods will use this secret to pull images from the configured registry

## Troubleshooting

If you get authentication errors:
1. Verify your `.env` file has the correct credentials
2. Ensure the environment variables are loaded: `echo $DOCKER_USERNAME`
3. Check that the secret was created: `kubectl get secret ghcr-login-secret -n workshop-ia`
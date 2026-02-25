# Set the FTL URL variable 
FTL_URL="https://ai-ftl-server.dp1.atsnl-emea.azure.dataplanes.pro"

# Get the directory where this script is located

SCRIPT_DIR="$(dirname "$0")"
echo "===================================================="
echo "   Active Spaces Vector Store: Schema Management"
echo "===================================================="

echo "[1/2] Deleting existing tables"
docker run --rm --network host -v "$SCRIPT_DIR/tables_delete.cfg":/tmp/tables_delete.cfg ghcr.io/mbloomfi-tibco/as-tibdg:5.0.0 -r  "$FTL_URL" -s /tmp/tables_delete.cfg

echo "[2/2] Creating tables with row_counts enabled..."
docker run --rm --network host -v "$SCRIPT_DIR/tables_create.cfg":/tmp/tables_create.cfg  ghcr.io/mbloomfi-tibco/as-tibdg:5.0.0 -r "$FTL_URL" -s /tmp/tables_create.cfg

@echo off
setlocal

:: Set the FTL URL variable (Internal Docker Network Name)
set FTL_URL="https://ai-ftl-server.dp1.atsnl-emea.azure.dataplanes.pro:80"

echo ====================================================
echo   Active Spaces Vector Store: Schema Management
echo ====================================================

echo [1/3] Deleting existing tables (if any)...
docker run --rm --network host -v ./tables_delete.cfg:/tmp/tables_delete.cfg  ghcr.io/mbloomfi-tibco/as-tibdg:5.0.0 -r "%FTL_URL%" -s /tmp/tables_delete.cfg

echo [2/3] Creating tables...
docker run --rm --network host -v ./tables_create.cfg:/tmp/tables_create.cfg  ghcr.io/mbloomfi-tibco/as-tibdg:5.0.0 -r "%FTL_URL%" -s /tmp/tables_create.cfg

echo [3/3] Check tables
docker run --rm --network host ghcr.io/mbloomfi-tibco/as-tibdg:5.0.0 -r "%FTL_URL%" table list
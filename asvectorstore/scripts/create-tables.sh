#!/bin/bash

# Set the FTL URL variable (Internal Docker Network Name)
FTL_URL="http://ftlserver_0:13031"

# Helper function to reduce repetition
run_config() {
    docker compose run --rm config -r "$FTL_URL" "$@"
}

echo "===================================================="
echo "   Active Spaces Vector Store: Schema Management"
echo "===================================================="

echo "[1/3] Deleting existing tables (if any)..."
run_config table delete ds_store_sampleas
run_config table delete ds_event_sampleas
run_config table delete vs_store_sampleas_doc
run_config table delete vector_store
run_config table delete document_store

echo "[2/3] Creating tables with row_counts enabled..."
# Ensure row_counts=exact is the FIRST argument after 'table create'
run_config table create row_counts=exact ds_store_sampleas doc_id long
run_config table create row_counts=exact ds_event_sampleas event_id long
run_config table create row_counts=exact vs_store_sampleas_doc vector_id long
run_config table create row_counts=exact vector_store vector_store string
run_config table create row_counts=exact document_store document_store string

echo "[3/3] Creating columns..."

# ds_store_sampleas columns
run_config column create ds_store_sampleas doc_title string
run_config column create ds_store_sampleas status string
run_config column create ds_store_sampleas chunks long
run_config column create ds_store_sampleas vector_store string 
run_config column create ds_store_sampleas metadata string
run_config column create ds_store_sampleas last_update datetime

# ds_event_sampleas columns
run_config column create ds_event_sampleas doc_id long
run_config column create ds_event_sampleas event string
run_config column create ds_event_sampleas notes string
run_config column create ds_event_sampleas time_stamp datetime

# vs_store_sampleas_doc columns
run_config column create vs_store_sampleas_doc doc_id long
run_config column create vs_store_sampleas_doc chunk_number long
run_config column create vs_store_sampleas_doc chunk_text string
run_config column create vs_store_sampleas_doc embedding opaque
run_config column create vs_store_sampleas_doc metadata string

# vector_store columns
run_config column create vector_store embedding_model string

# document_store columns
run_config column create document_store title string
run_config column create document_store description string

echo "===================================================="
echo "   Schema update complete!"
echo "===================================================="

# Replaces the 'pause' command in Windows
read -p "Press [Enter] key to continue..."
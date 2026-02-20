@echo off
setlocal

:: Set the FTL URL variable (Internal Docker Network Name)
set FTL_URL=http://ftlserver_0:13031

echo ====================================================
echo   Active Spaces Vector Store: Schema Management
echo ====================================================

echo [1/3] Deleting existing tables (if any)...
docker compose run --rm config -r "%FTL_URL%" table delete ds_store_sampleas
docker compose run --rm config -r "%FTL_URL%" table delete ds_event_sampleas
docker compose run --rm config -r "%FTL_URL%" table delete vs_store_sampleas_doc
docker compose run --rm config -r "%FTL_URL%" table delete vector_store
docker compose run --rm config -r "%FTL_URL%" table delete document_store

echo [2/3] Creating tables with row_counts enabled...
:: Ensure row_counts=exact is the FIRST argument after 'table create'
docker compose run --rm config -r "%FTL_URL%" table create row_counts=exact ds_store_sampleas doc_id long
docker compose run --rm config -r "%FTL_URL%" table create row_counts=exact ds_event_sampleas event_id long
docker compose run --rm config -r "%FTL_URL%" table create row_counts=exact vs_store_sampleas_doc vector_id long
docker compose run --rm config -r "%FTL_URL%" table create row_counts=exact vector_store vector_store string
docker compose run --rm config -r "%FTL_URL%" table create row_counts=exact document_store document_store string

echo [3/3] Creating columns...

:: ds_store_sampleas columns
docker compose run --rm config -r "%FTL_URL%" column create ds_store_sampleas doc_title string
docker compose run --rm config -r "%FTL_URL%" column create ds_store_sampleas status string
docker compose run --rm config -r "%FTL_URL%" column create ds_store_sampleas chunks long
docker compose run --rm config -r "%FTL_URL%" column create ds_store_sampleas vector_store string 
docker compose run --rm config -r "%FTL_URL%" column create ds_store_sampleas metadata string
docker compose run --rm config -r "%FTL_URL%" column create ds_store_sampleas last_update datetime

:: ds_event_sampleas columns
docker compose run --rm config -r "%FTL_URL%" column create ds_event_sampleas doc_id long
docker compose run --rm config -r "%FTL_URL%" column create ds_event_sampleas event string
docker compose run --rm config -r "%FTL_URL%" column create ds_event_sampleas notes string
docker compose run --rm config -r "%FTL_URL%" column create ds_event_sampleas time_stamp datetime

:: vs_store_sampleas_doc columns
docker compose run --rm config -r "%FTL_URL%" column create vs_store_sampleas_doc doc_id long
docker compose run --rm config -r "%FTL_URL%" column create vs_store_sampleas_doc chunk_number long
docker compose run --rm config -r "%FTL_URL%" column create vs_store_sampleas_doc chunk_text string
docker compose run --rm config -r "%FTL_URL%" column create vs_store_sampleas_doc embedding opaque
docker compose run --rm config -r "%FTL_URL%" column create vs_store_sampleas_doc metadata string

:: vector_store columns
docker compose run --rm config -r "%FTL_URL%" column create vector_store embedding_model string

:: document_store columns
docker compose run --rm config -r "%FTL_URL%" column create document_store title string
docker compose run --rm config -r "%FTL_URL%" column create document_store description string

echo ====================================================
echo   Schema update complete!
echo ====================================================
pause
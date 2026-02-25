#Content#
This document contains instructions for the setup of the active spaces (and the population of the databases) required for the AI workshop

Step 1: Edit the .env file
Make sure the variable 'FTL_URL' points to the ftl container (deployed as part of AS) on the data plane.

Step 2: Go to script directory

```bash
cd scripts
```

Step 3: Create the required tables in Active Spaces. Please mind: existing tables will be deleted first!

```bash
create-tables
```

Please note: this script will remove any existing tables and create new tables.


Step 4: ingest the sample documents
As part of the workshop, a number of sample documents must be loaded. These are located in the directory 'documents' in this repository. The flogo app flogo/ingestsamplefileslocal.flogo needs to be run to ingest the files. In the directory 'bin' (in this repository), a windows and a linux binary can be found. To run the app, use the following steps:


Step 4a: go to the bin directory

Step 4b: Edit the ingestfile-props.json file. Fill out the following parameters:

- **AsDocumentStoreHostAndPort**: Hostname and port of the AS Document store. Example: `localhost:50052`
- **AsVectorStoreHostAndPort**: Hostname and port of the AS Vector Store. Example: `localhost:50051`
- **DoclingHost**: URL of the Docling container. Example: `http://localhost`
- **DoclingPort**: Port of the Docling container. Example: `5001`
- **DocumentStore**: Name of the document store. Use: `ds_store_sampleas`
- **FilesDirectory**: Directory containing .md files to ingest. Use: `..\\documents`
- **VectorStore**: Name of the vector store used in AS. Use: `vs_store_sampleas_doc`
- **EmbeddingURL**: URL where Ollama is available for embeddings. Example: `http://localhost`
- **EmbeddingPort**: Port where Ollama is available for embeddings. Example: `11434`



Step 4c: Create the following export.
The environment variable FLOGO_APP_PROPS_JSON must point to ingestfile-props.json file:

```bash
export FLOGO_APP_PROPS_JSON=<full path>/bin/ingestfile-props.json
```

Step 4d: Run the application: 
```bash
./ingestsamplefileslocal
```

The application will run for about 1 minute. During the run the the documents and chunks will show on the screen.

Step 4e: test the result
Run the following command to get an overview of the documents stored in AS. There should be 11 documents.
Please mind: for this grpcurl must be installed.


```bash
cd ..
grpcurl -plaintext -proto proto/as-vdb-documentstore.proto -d "{\"DocumentStore\": \"ds_store_sampleas\"}" localhost:50052 documentstore.DocumentStore/GetDocument
```


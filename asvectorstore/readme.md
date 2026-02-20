#Content#
This document contains instructions for the setup of the active spaces required for the AI workshop

Step 1: Edit the .env file
Step 2: Go to script directory

```bash
cd scripts
```

Step 3: Create the required tables in Active Spaces. Please mind: existing tables will be deleted first!

```bash
create-tables
```

Step 4: ingest the sample documents
The flogo app flogo/ingestsamplefileslocal.flogo needs to be run to ingest a collection of md files in the directory 'documents'.


Step 4a: go to the bin directory

Step 4b: Edit the ingestfile-props.json file. 

Step 4c: Create the following export.

```bash
export FLOGO_APP_PROPS_JSON=<full path>/bin/ingestfile-props.json
```

Step 4d: Run the application: 
```bash
./ingestsamplefiles
```bash



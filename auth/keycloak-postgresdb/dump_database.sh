#!/bin/bash

# Run these inside postgres container: `kubectl exec -it postgres -- bash`
# Then copy the files out of the container: `kubectl exec -it postgres -- cat <containerfile> > <localfile>`

export PGHOST=localhost
export PGPORT=5432
export PGDATABASE=keycloakdb
export PGUSER=admin
export PGPASSWORD=admin

pg_dump --schema-only --file 01-dump-schema-only.sql
pg_dump --data-only --file 02-dump-data-only.sql

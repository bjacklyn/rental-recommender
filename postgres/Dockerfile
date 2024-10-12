FROM postgres:17.0

COPY 01-dump-schema-only.sql /docker-entrypoint-initdb.d/01-dump-schema-only.sql
COPY 02-dump-data-only.sql /docker-entrypoint-initdb.d/02-dump-data-only.sql

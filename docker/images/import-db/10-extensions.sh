#!/usr/bin/env bash

set -euo pipefail

# enable uuid extension
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-SQL
create extension if not exists "uuid-ossp";
SQL

#!/usr/bin/env bash

set -euo pipefail

# create databases
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-SQL
create database satelit_index;
create database satelit_import;
create database satelit_scheduler;

grant all privileges on database satelit_index to $POSTGRES_USER;
grant all privileges on database satelit_import to $POSTGRES_USER;
grant all privileges on database satelit_scheduler to $POSTGRES_USER;
SQL

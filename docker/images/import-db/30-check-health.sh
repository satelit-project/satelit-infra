#!/usr/bin/env sh
#
# Checks is database is ready to accept connections

set -euo pipefail

main() {
  local user="${POSTGRES_USER:-postgres}"
  local db="${POSTGRES_DB:-$user}"
  pg_isready -q -U "$user" -d "$db" || exit 1
}

main "$@"

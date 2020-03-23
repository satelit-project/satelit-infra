#!/usr/bin/env fish
#
# Generates .env file with required environment variables.

set DIR (dirname (status --current-file))
set ENV $DIR/resources/.env

function put_env
  if not set -q $argv[1]
    read -P "Provide value for $argv[1]: " $argv[1]
  end

  echo "$argv[1]="$$argv[1] >> $ENV
end

function main
  if test -f $ENV
    rm -f $ENV
  end

  put_env DO_SPACES_KEY
  put_env DO_SPACES_SECRET
  put_env DO_SPACES_HOST
  put_env DO_BUCKET
end

main $argv

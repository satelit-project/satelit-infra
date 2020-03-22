#!/usr/bin/env bash
#
# Creates necessary directories to copy resources

set -euo pipefail

source "/tmp/common.sh"

USER_NAME="$USER_NAME"

assert_home_dir() {
  if [[ ! -d "/home/$USER_NAME" ]]; then
    echo "Home directory for user $USER_NAME does not exists"
    exit 1
  fi
}

main() {
  assert_home_dir

  local me="$(whoami)"
  doas mkdir "/home/$USER_NAME/satelit-import"
  doas chown -R "$me:$me" "/home/$USER_NAME/satelit-import"
}

main "$@"

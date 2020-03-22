#!/usr/bin/env bash
#
# Configures permissions for copied resources

set -euo pipefail

USER_NAME="$USER_NAME"

source "/tmp/common.sh"

main() {
  doas chown -R "$USER_NAME:$USER_NAME" "/home/$USER_NAME"
}

main "$@"

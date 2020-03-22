#!/usr/bin/env bash
#
# Creates default user and disables root

set -euo pipefail

USER_NAME="$USER_NAME"
USER_PASSWD="$USER_PASSWD"

source "/tmp/common.sh"

add_user() {
  doas useradd -mU -G sudo -s /bin/bash "$USER_NAME"
  echo "$USER_NAME:$USER_PASSWD" | doas chpasswd
}

lock_root() {
  doas passwd -l root
}

main() {
  add_user
  lock_root
}

main "$@"

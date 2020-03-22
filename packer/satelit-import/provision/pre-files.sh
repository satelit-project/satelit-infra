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

  # prepare user dirs
  local dirs=( "satelit-import" ".ssh" )
  for dir in "${dirs[@]}"; do
    doas mkdir "/home/$USER_NAME/$dir"
    doas chown "$me:$me" "/home/$USER_NAME/$dir"
  done

  # prepare ssh daemon dir
  doas chown "$me:$me" /etc/ssh
  doas rm /etc/ssh/sshd_config

  # create directory for the postgres container
  doas mkdir /mnt/satelit_import/pgdata
}

main "$@"

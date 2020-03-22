#!/usr/bin/env bash
#
# Configures automatic volumes mount.

set -euo pipefail

source "/tmp/common.sh"

main() {
  doas mkdir -p /mnt/satelit_import
  echo 'LABEL=satelit_import /mnt/satelit_import ext4 defaults,nofail,discard 0 0' \
    | doas tee -a /etc/fstab
}

main "$@"

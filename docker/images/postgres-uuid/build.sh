#!/usr/bin/env bash
#
# Build new postgres-uuid image and pushes it to Github.
# Before you can push images to Github, you need to login:
# `docker login`

set -euo pipefail

ROOT_DIR="$(set -e; git rev-parse --show-toplevel)"
DIR="$(set -e; cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

source "$ROOT_DIR/docker/common/exec.sh"

IMAGE_REPO="satelit"
NAME="postgres-uuid"
VERSION="$(set -e; head -n1 Dockerfile | cut -d':' -f2)"

main() {
  pushd "$DIR" >/dev/null

  docker build -t "$IMAGE_REPO/$NAME:$VERSION" .
  docker push "$IMAGE_REPO/$NAME:$VERSION"

  popd >/dev/null
}

main "$@"

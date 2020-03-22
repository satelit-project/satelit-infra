#!/usr/bin/env fish
#
# Build new image and pushes it to remote.
# Be sure to login first: docker login.

set ROOT_DIR (git rev-parse --show-toplevel)
set SCRIPT_DIR (dirname (status --current-file))

source $ROOT_DIR/docker/common/exec.fish

set IMAGE_REPO "satelit"
set NAME "import-db"
set VERSION (head -n1 $SCRIPT_DIR/Dockerfile | cut -d':' -f2)

function main
  pushd $ROOT_DIR/docker/images/$NAME >/dev/null

  docker build -t "$IMAGE_REPO/$NAME:$VERSION" .
  docker push "$IMAGE_REPO/$NAME:$VERSION"

  popd >/dev/null
end

main $argv

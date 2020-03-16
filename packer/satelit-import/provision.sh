#!/usr/bin/env bash
#
# Prepares Ubuntu image to run anime import services.

set -euo pipefail

prepare_apt() {
  sudo apt-get update
  sudo apt-get install -y \
      apt-transport-https \
      ca-certificates \
      curl \
      gnupg-agent \
      software-properties-common
}

install_docker() {
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  sudo add-apt-repository \
      "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) \
      stable"

  sudo apt-get update
  sudo apt-get install -y docker-ce docker-ce-cli containerd.io
}

main() {
    prepare_apt
    install_docker
}

main "$@"

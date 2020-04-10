#!/usr/bin/env bash
#
# Installs required dependencies.

set -euo pipefail

source "/tmp/common.sh"

install_docker() {
  doas apt-get update
  doas apt-get install -y \
      apt-transport-https \
      ca-certificates \
      curl \
      gnupg-agent \
      software-properties-common

  curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
    | doas apt-key add -
  doas add-apt-repository \
      "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) \
      stable"

  doas apt-get update
  doas apt-get install -y docker-ce docker-ce-cli containerd.io
}

install_compose() {
  local ver="1.25.4"
  doas curl -L \
    "https://github.com/docker/compose/releases/download/${ver}/docker-compose-$(uname -s)-$(uname -m)" \
    -o /usr/local/bin/docker-compose

  doas chmod +x /usr/local/bin/docker-compose
}

install_monitoring_agent() {
  echo "deb https://repos.insights.digitalocean.com/apt/do-agent/ main main" \
    | doas dd of=/etc/apt/sources.list.d/digitalocean-agent.list

  curl https://repos.insights.digitalocean.com/sonar-agent.asc \
    | doas apt-key add -

  doas apt-get update
  doas apt-get install do-agent
}

install_mosh() {
  doas apt-get update
  doas apt-get install mosh
}

main() {
  install_docker
  install_compose
  install_monitoring_agent
  install_mosh
}

main "$@"

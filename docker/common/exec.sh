docker() {
  local kernel
  kernel="$(uname -s)"

  if [[ "${kernel,,}" == "linux" ]]; then
    command sudo docker "$@"
  else
    command docker "$@"
  fi
}

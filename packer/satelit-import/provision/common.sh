# Runs a command as superuser if needed.
# Args:
#   $@ - command with optional arguments to run.
doas() {
  if [[ "$(whoami)" == "vagrant" ]]; then
    sudo -- "$@"
  else
    "$@"
  fi
}

function docker
  if test (uname | string lower) = linux
    command sudo docker $argv
  else
    command docker $argv
  end
end

docker_name='open-edx'

if ! docker start -i ${docker_name}
  then
    docker run \
      --name ${docker_name} \
      --hostname ${docker_name} \
      -w /setup \
      -v "$(pwd):/setup" \
      -p 8085:80 -p 80 -p 8443 \
      -ti ubuntu:16.04 \
      /bin/bash
  fi
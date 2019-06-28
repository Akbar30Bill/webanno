#!/bin/bash

if["$USER" -eq 'root'];then
  mkdir /srv/webanno
  echo installing Docker
  apt install docker -y
  apt install docker.io -y
  echo Port to use:
  read Port
  echo Run Webanno in background?[Y/n]:
  read background
  if["$background" -eq 'y'] || ["$background" -eq 'Y'];then
    docker run -d --name webanno -v /srv/webanno:/export -p$Port:$Port webanno/webanno:3.5.7
  else
    docker run -it --name webanno -v /srv/webanno:/export -p$Port:$Port webanno/webanno:3.5.7
  fi
  echo creating systemd service
  cp webanno.service /etc/systemd/system/webanno.service
  systemctl enable webanno
  echo Done!
else
  echo Please run with Superuser privilage
fi

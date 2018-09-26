#!/bin/bash -x

# compiled from https://docs.docker.com/engine/installation/linux/debian/

function install_docker_working_folder {
  if [ -d /data ] ;then 
    local storage=/data/srv/lib/docker
  else
    local storage=/srv/lib/docker
  fi
  [[ ! -d ${storage} ]] && sudo mkdir -p ${storage}
  [[ ! -d /var/lib/docker ]] && sudo ln -s ${storage} /var/lib/docker
  return 0
} 

function install_docker {
  sudo apt-get update
  sudo apt-get install -y apt-transport-https ca-certificates wget software-properties-common

  sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

  wget https://download.docker.com/linux/debian/gpg -O - | sudo apt-key add -

  echo "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list
  sudo apt install -y docker-ce docker-compose
}

function install_docker_permissions {
  sudo usermod -a -G docker ${USER}
}

install_docker_working_folder && install_docker && install_docker_permissions
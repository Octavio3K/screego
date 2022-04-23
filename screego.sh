#!/bin/bash
#Chequea permisos de administrador.
permisos(){
if [ "$(whoami)" != "root" ]
  then echo "Este script debe ejecutarse con permisos de root"
  exit 1
fi
}

#Dependencias
apt install curl -y

#Descarga y ejecuta el script de instalación de Docker desatendido 
instalaDocker(){
	curl -fsSL get.docker.com -o get-docker.sh
	sudo sh get-docker.sh
}

instalaDockerCompose(){
	sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
	sudo chmod +x /usr/local/bin/docker-compose
}


configScreego(){
 	local miIP=$(ip route get 8.8.8.8 | sed -n '/src/{s/.*src *\([^ ]*\).*/\1/p;q}')
 	cat <<EOF > docker-compose.yml
version: "3.7"
services:
  screego:
    image: screego/server:1.6.2
    network_mode: host
    environment:
      SCREEGO_EXTERNAL_IP: "${miIP}"
EOF

 }

permisos
instalaDocker
docker -v
instalaDockerCompose
docker-compose --version
configScreego
docker-compose up

#sudo apt-get install qemu-kvm libvirt-daemon-system
#libvirt-clients bridge-utils virt-manager

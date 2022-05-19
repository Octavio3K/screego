#!/bin/bash
#Chequea permisos de administrador.
permisos(){
if [ "$(whoami)" != "root" ]
  then echo "Este script debe ejecutarse con permisos de root"
  exit 1
fi
}

#Dependencias

if ! command -v curl &> /dev/null
then
  apt install curl -y
fi

if ! command -v qrencode &> /dev/null
then
  apt install qrencode -y
fi

if ! command -v convert-im6.q16 &> /dev/null
then
  apt install imagemagick-6.q16 -y
fi


#Instalación de docker desatendido 
instalaDocker(){
	if ! command -v docker &> /dev/null
  then
    curl -fsSL get.docker.com -o get-docker.sh
    sudo sh get-docker.sh
fi

}
#Instalación de docker-compose desatendido 
instalaDockerCompose(){
	if ! command -v docker-compose &> /dev/null
  then
  sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
	sudo chmod +x /usr/local/bin/docker-compose
fi
}

#
configScreego(){
 	local miIP=$(ip route get 8.8.8.8 | sed -n '/src/{s/.*src *\([^ ]*\).*/\1/p;q}')
 	cat <<EOF > docker-compose.yml
version: "3.7"
services:
  screego:
    image: screego/server:1.6.2
    network_mode: host
    volumes:
    - ./:/app
    environment:
      SCREEGO_EXTERNAL_IP: "${miIP}"
      SCREEGO_SERVER_TLS: 'false'
EOF

 }

creaLanzadorHostname(){
  cat <<EOF > Profesor.html
  <html>
    <head>
        <meta http-equiv="refresh" content="0; url=http://localhost:5050/?room=pantalla&create=true" />
    </head>
    <body> </body>
</html>
EOF
}

creaLanzadorCliente(){
  local miIP=$(ip route get 8.8.8.8 | sed -n '/src/{s/.*src *\([^ ]*\).*/\1/p;q}')
  cat <<EOF > Alumno.html
  <html>
    <head>
        <meta http-equiv="refresh" content="0; url=http://${miIP}:5050/?room=pantalla" />
    </head>
    <body> </body>
</html>
EOF

}
crearQR(){
  local miIP=$(ip route get 8.8.8.8 | sed -n '/src/{s/.*src *\([^ ]*\).*/\1/p;q}')

  qrencode -s 12 -o qrcode.png "http://${miIP}:5050/?room=pantalla"
  convert qrcode.png -gravity South -pointsize 20 -annotate +0 "http://${miIP}:5050/?room=pantalla" qrcode.png
}


permisos
instalaDocker
docker -v
instalaDockerCompose
docker-compose --version
configScreego
creaLanzadorHostname
creaLanzadorCliente
crearQR
docker-compose up



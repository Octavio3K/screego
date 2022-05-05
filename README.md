Paso 1: abrir una terminal
Paso 2: Ejecutar el comando: chmod 777 screego.sh
Paso 3: Ejecutar el comando: chmod 777 cert.sh
Paso 4: Ejecutar el comando: sudo ./cert.sh
Paso 5: Ejecutar el comando: sudo ./screego.sh
Paso 6: En el navegador [profesor] abrir la pagina: https://localhost:5050/?room=sala1 y darle en Create Room
Para ver la ip en la terminal ejecutar: ifconfig | grep 192.168 | awk '{print $2}'
Paso 7: En el navegador  [Alumno] Abrir la pagina: https://*ipmaquinaprofesor*:5050/?room=sala1

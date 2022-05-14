Paso 1: abrir una terminal

Paso 2: Ejecutar el comando: sudo bash cert.sh

Paso 3: Ejecutar el comando: sudo bash screego.sh

Paso 4: En el navegador [profesor] abrir la pagina: https://localhost:5050/?room=**nombre-de-la-sala** y darle en Create Room

Para ver la ip en la terminal ejecutar: "ip route get 8.8.8.8 | sed -n '/src/{s/.*src *\([^ ]*\).*/\1/p;q}'"

Paso 5: En el navegador [Alumno] Abrir la pagina: https://**ipmaquinaprofesor**:5050/?room=**nombre-de-la-sala**

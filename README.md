## Configuración de PostgreSQL con Docker

# Integrantes:

- Andrés Felipe Alcántara Muñoz: andres.alcantara@correounivalle.edu.co
- Miguel Angel Salcedo Urián: salcedo.miguel@correounivalle.edu.co
- Elkin Samir Angulo: elkin.angulo@correounivalle.edu.co
- Cristian Camilo Pinzón: pinzon.cristian@correounivalle.edu.co
- Leonardo Cuadro López: leonardo.cuadro@correounivalle.edu.co


### Introducción
Este repositorio contiene instrucciones sobre cómo configurar un entorno de PostgreSQL utilizando Docker. A continuación se detallan los comandos necesarios para crear una red, un volumen y ejecutar contenedores de PostgreSQL, así como realizar diversas operaciones en la base de datos.

### Requisitos previos
- Docker instalado en tu sistema

### Comandos

#### 1. Crear Red de Docker
```bash
docker network create pg_network
```
Crea una red de Docker llamada `pg_network` para la comunicación entre los contenedores de PostgreSQL.

#### 2. Crear Volumen de Docker
```bash
docker volume create --name pg_db
```
Crea un volumen de Docker llamado `pg_db` para persistir los datos de PostgreSQL.

#### 3. Ejecutar Contenedor del Servidor PostgreSQL
```bash
docker container run --network pg_network --name pg_server -e POSTGRES_PASSWORD=myStrong#Password -v pg_db:/var/lib/postgresql/data -d postgres:15-bookworm
```
Ejecuta un contenedor del servidor PostgreSQL llamado `pg_server` utilizando la versión 15-bookworm, con una contraseña predefinida y un volumen adjunto `pg_db`.

#### 4. Ejecutar Contenedor del Cliente PostgreSQL
```bash
docker container run --network pg_network --name pg_client -e POSTGRES_PASSWORD=myStrong#Password -d postgres:15-bookworm
```
Ejecuta un contenedor del cliente PostgreSQL llamado `pg_client` conectado a la `pg_network`.

#### 5. Acceder al Contenedor del Servidor PostgreSQL
```bash
docker container exec -it pg_server /bin/bash
```
Ingresa a la shell del contenedor del servidor PostgreSQL.

#### 6. Acceder a la Base de Datos PostgreSQL
```bash
psql -h localhost -U postgres
```
Accede a la base de datos PostgreSQL utilizando la herramienta de línea de comandos `psql`.

#### 7. Crear Base de Datos
```sql
CREATE DATABASE tarea_db;
```
Crea una base de datos llamada `tarea_db` dentro del servidor PostgreSQL.

#### 8. Conectar a la Base de Datos
```sql
\c tarea_db;
```
Conecta a la base de datos `tarea_db`.

#### 9. Crear Tabla
```sql
CREATE TABLE pg_tabla(id SERIAL PRIMARY KEY, mensaje TEXT NOT NULL);
```
Crea una tabla llamada `pg_tabla` con las columnas `id` y `mensaje`.

#### 10. Insertar Datos
```sql
INSERT INTO pg_tabla(mensaje) VALUES ('hola mundo');
```
Inserta un registro con el mensaje 'hola mundo' en la tabla `pg_tabla`.

#### 11. Consultar Datos
```sql
SELECT * FROM pg_tabla;
```
Recupera todos los registros de la tabla `pg_tabla`.

#### 12. Salir de psql
```sql
\q
```
Sale de la herramienta de línea de comandos de PostgreSQL.

#### 13. Salir de la Shell del Contenedor
```bash
exit
```
Sale de la shell del contenedor.

#### 14. Acceder al Contenedor del Cliente PostgreSQL
```bash
docker container exec -it pg_client /bin/bash
```
Ingresa a la shell del contenedor del cliente PostgreSQL.

#### 15. Acceder a la Base de Datos PostgreSQL desde el Cliente
```bash
psql -h pg_server -p 5432 -U postgres tarea_db
```
Conecta a la base de datos `tarea_db` alojada en `pg_server` desde el contenedor del cliente.

#### 16. Consultar Datos desde el Cliente
```sql
SELECT * FROM pg_tabla;
```
Recupera datos de la tabla `pg_tabla` dentro del contenedor del cliente.

#### 17. Salir de psql desde el Cliente
```sql
\q
```
Sale de la herramienta de línea de comandos de PostgreSQL dentro del contenedor del cliente.

#### 18. Salir de la Shell del Contenedor del Cliente
```bash
exit
```
Sale de la shell del contenedor del cliente.

#### 19. Limpieza
```bash
docker container stop $(docker container ls -q)
docker container rm -f pg_client
docker container rm -f pg_server
docker volume rm pg_db
docker network rm pg_network
```
Detiene y elimina los contenedores, elimina los volúmenes y la red de Docker para limpiar el entorno.

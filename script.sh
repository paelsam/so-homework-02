docker network create pg_network
docker volume create --name pg_db

docker container run --network pg_network --name pg_server -e POSTGRES_PASSWORD=myStrong#Password -v pg_db:/var/lib/postgresql/data -d postgres:15-bookworm

docker container run --network pg_network --name pg_client -e POSTGRES_PASSWORD=myStrong#Password -d postgres:15-bookworm 

docker container exec -it pg_server /bin/bash

psql -h localhost -U postgres

CREATE DATABASE tarea_db;

\c tarea_db;

CREATE TABLE pg_tabla(id SERIAL PRIMARY KEY, mensaje TEXT NOT NULL);

INSERT INTO pg_tabla(mensaje) VALUES (‘hola mundo’);

SELECT * FROM pg_tabla;

\q

exit

docker container exec -it pg_client /bin/bash

psql -h pg_server -p 5432 -U postgres tarea_db

SELECT * FROM pg_tabla;

\q

exit

docker container stop $(docker container ls -q)
docker container rm -f pg_client
docker container rm -f pg_server
docker volume rm pg_db
docker network rm pg_network


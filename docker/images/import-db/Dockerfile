FROM postgres:12-alpine

ENV POSTGRES_HOST_AUTH_METHOD trust  # the db is not exposed to outside world
COPY 10-extensions.sh 20-init.sh /docker-entrypoint-initdb.d/

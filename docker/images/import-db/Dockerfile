FROM postgres:12-alpine

ENV POSTGRES_HOST_AUTH_METHOD trust
ENV PGDATA /var/lib/postgresql/data/pgdata

COPY 10-extensions.sh 20-init.sh /docker-entrypoint-initdb.d/
COPY 30-check-health.sh /import-db/

HEALTHCHECK --interval=30s --timeout=10s --start-period=10s --retries=4 \
    CMD ["/import-db/30-check-health.sh"]

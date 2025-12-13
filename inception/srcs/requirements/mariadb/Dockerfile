FROM debian:bookworm

RUN apt-get update && apt-get install -y mariadb-server netcat-traditional

COPY tools/docker-entrypoint.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
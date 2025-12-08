ARG DEBIAN_PENULTIMATE=debian:bullseye
FROM ${DEBIAN_PENULTIMATE}

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y mariadb-server \
    && rm -rf /var/lib/apt/lists/*

VOLUME /var/lib/mysql
EXPOSE 3306

COPY tools/docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["mysqld"]

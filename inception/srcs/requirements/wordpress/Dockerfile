FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    php7.4  php7.4-fpm php7.4-mysql php7.4-xml php7.4-mbstring curl netcat-openbsd

RUN mkdir -p /var/www/html /run/php && chown -R www-data:www-data /var/www/html

COPY tools/docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]

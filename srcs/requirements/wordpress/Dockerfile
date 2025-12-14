FROM debian:bookworm

RUN apt-get update && apt-get install -y \
    php  php-fpm php-mysql curl netcat-traditional

RUN mkdir -p /var/www/html /run/php && chown -R www-data:www-data /var/www/html

COPY tools/docker-entrypoint.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]

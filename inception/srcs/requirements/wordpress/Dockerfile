FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    php7.4-fpm php7.4-mysql php7.4-xml php7.4-mbstring wget unzip curl

RUN sed -i 's|listen = /run/php/php7.4-fpm.sock|listen = 9000|g' /etc/php/7.4/fpm/pool.d/www.conf

RUN mkdir -p /var/www/html /run/php && chown -R www-data:www-data /var/www/html

COPY tools/docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]

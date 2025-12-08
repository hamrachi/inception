ARG DEBIAN_PENULTIMATE=debian:bullseye
FROM ${DEBIAN_PENULTIMATE}

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    php7.4-fpm php7.4-mysql php7.4-xml php7.4-mbstring wget unzip curl \
    && rm -rf /var/lib/apt/lists/*

RUN sed -i 's|listen = /run/php/php7.4-fpm.sock|listen = 9000|g' /etc/php/7.4/fpm/pool.d/www.conf

RUN mkdir -p /var/www/html /run/php && chown -R www-data:www-data /var/www/html

COPY tools/docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

EXPOSE 9000
VOLUME /var/www/html

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["php-fpm7.4", "-F"]

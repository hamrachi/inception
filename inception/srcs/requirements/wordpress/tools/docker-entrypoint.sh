#!/bin/bash
set -e

mkdir -p /run/php

if [ ! -f /var/www/html/wp-config.php ] && [ ! -f /var/www/html/index.php ]; then
  echo "Downloading WordPress..."
  wget -qO /tmp/wordpress.tar.gz https://wordpress. org/latest.tar.gz
  tar -xzf /tmp/wordpress.tar.gz -C /tmp
  cp -R /tmp/wordpress/* /var/www/html/
  chown -R www-data:www-data /var/www/html
  rm -rf /tmp/wordpress /tmp/wordpress.tar.gz
fi

exec "$@"

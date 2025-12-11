#!/bin/bash

set -e

sleep 10

# 1. Install WP-CLI if needed
if [ ! -f "/usr/local/bin/wp" ]; then
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
    mv wp-cli.phar /usr/local/bin/wp
fi

cd /var/www/html

# 2. Check if wp-config.php exists
if [ ! -f "wp-config.php" ]; then

    # FIX: Check if WordPress core files are already downloaded
    # If index.php doesn't exist, THEN download. Otherwise, skip to config.
    if [ ! -f "index.php" ]; then
        wp core download --allow-root
    fi

    # 3. Create config (Corrected variable syntax: "${VAR}")
    wp config create \
        --dbname="${MYSQL_DATABASE}" \
        --dbuser="${MYSQL_USER}" \
        --dbpass="${MYSQL_PASSWORD}" \
        --dbhost=mariadb \
        --allow-root

    # 4. Install WordPress
    wp core install \
        --url="${DOMAIN_NAME}" \
        --title="${WP_TITLE}" \
        --admin_user="${WP_ADMIN_USER}" \
        --admin_password="${WP_ADMIN_PASSWORD}" \
        --admin_email="${WP_ADMIN_EMAIL}" \
        --skip-email \
        --allow-root

    # 5. Create Author User
    wp user create \
        "${WP_USER}" "${WP_USER_EMAIL}" \
        --role=author \
        --user_pass="${WP_USER_PASSWORD}" \
        --allow-root
fi

sed -i 's|listen = /run/php/php7.4-fpm.sock|listen = 9000|g' /etc/php/7.4/fpm/pool.d/www.conf

exec php-fpm7.4 -F

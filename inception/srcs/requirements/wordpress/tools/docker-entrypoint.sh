#!/bin/bash

set -e

if [ ! -f "/usr/local/bin/wp" ]; then
	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
	chmod +x wp-cli.phar
	mv wp-cli.phar /usr/local/bin/wp
fi

cd /var/www/html

if [ ! -f "wp-confing.php" ]; then
	wp core download --allow-root

	wp config create --dbname=MYSQ --dbuser= --dbpass= --dbhost= --allow-root

	wp core install --url= --title= --admin_user= --admin_password= --admin_email= --skip-email --allow-root

	wp user create "wp_user" "wp_mail" --role= --user_pass= --allow-root
fi

exec php-fpm7.4 -F

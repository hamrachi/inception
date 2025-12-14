#!/bin/bash
set -e

service mariadb start

sleep 5

if [ ! -d "/var/lib/mysql/${MYSQL_DATABASE}" ]; then
    
    mariadb -u root <<-EOSQL
        CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
        CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
        GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
        ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
        FLUSH PRIVILEGES;
EOSQL

    mariadb-admin -u root -p${MYSQL_ROOT_PASSWORD} shutdown
    
else
    mariadb-admin -u root -p${MYSQL_ROOT_PASSWORD} shutdown
fi

exec mariadbd-safe --bind-address=0.0.0.0
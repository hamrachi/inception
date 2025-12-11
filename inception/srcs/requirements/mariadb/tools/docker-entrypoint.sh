#!/bin/bash

service mariadb start

sleep 5

mariadb <<-EOSQL
CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
EOSQL

mysqladmin  shutdown

exec mariadbd --bind-address=0.0.0.0 --datadir=/var/lib/mysql

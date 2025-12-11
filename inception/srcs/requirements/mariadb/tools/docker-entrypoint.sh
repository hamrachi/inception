#!/bin/bash

set -e

service start mariadb

sleep 5

DB_ROOT_PASS=$(cat /run/secrets/db_root_password)
DB_PASS=$(cat /run/secrets/db_password)

mysql -u root <<-EOSQL
  CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
  CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${DB_PASS}';
  GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
  FLUSH PRIVILEGES;
EOSQL

mysqladmin shutdown

exec mysqld --user=mysql --port=3306 --bind-address=0.0.0.0

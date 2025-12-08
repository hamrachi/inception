#!/bin/bash
set -e

mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld
chown -R mysql:mysql /var/lib/mysql

if [ !  -d /var/lib/mysql/mysql ]; then
  echo "Initializing MariaDB data directory..."
  mysql_install_db --user=mysql --datadir=/var/lib/mysql
fi

mysqld --user=mysql --skip-networking &
pid="$!"

echo "Waiting for MariaDB to start..."
sleep 10

DB_ROOT_PASS=$(cat /run/secrets/db_root_password)
DB_PASS=$(cat /run/secrets/db_password)

mysql -u root <<-EOSQL
  ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASS}';
  CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
  CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${DB_PASS}';
  GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
  FLUSH PRIVILEGES;
EOSQL

kill "$pid"
wait "$pid"

exec mysqld --user=mysql --port=3306 --bind-address=0.0.0.0

#!/bin/bash
service mariadb start

# Wait for MariaDB
until mysqladmin ping --silent; do sleep 1; done

# Create database and user
mysql -e "CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\`;"
mysql -e "CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';"
mysql -e "GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO '${DB_USER}'@'%';"
mysql -e "FLUSH PRIVILEGES;"

service mariadb stop
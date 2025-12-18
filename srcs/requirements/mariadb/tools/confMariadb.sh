#!/bin/bash
service mariadb start
mysqladmin -u root password "password"
mysql -e "rename user 'root'@'localhost' to 'root'@'%'"
service mariadb stop
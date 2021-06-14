#!/bin/bash

yum install expect -y

MYSQL_ROOT_PASSWORD=password

SECURE_MYSQL=$(expect -c "
set timeout 5
spawn mysql_secure_installation
expect \"Enter current password for root\"
send \"\r\"
expect \"Set root password?\"
send \"y\r\"
expect \"New password:\"
send \"$MYSQL_ROOT_PASSWORD\r\"
expect \"Re-enter new password:\"
send \"$MYSQL_ROOT_PASSWORD\r\"
expect \"Remove anonymous users?\"
send \"y\r\"
expect \"Disallow root login remotely?\"
send \"y\r\"
expect \"Remove test database and access to it?\"
send \"y\r\"
expect \"Reload privilege tables now?\"
send \"y\r\"
expect eof
")

echo "$SECURE_MYSQL"
mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "CREATE USER 'wiki'@'localhost' IDENTIFIED BY 'password';"
mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "CREATE DATABASE wikidatabase;"
mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "GRANT ALL PRIVILEGES ON wikidatabase.* TO 'wiki'@'localhost';"
mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "FLUSH PRIVILEGES;"

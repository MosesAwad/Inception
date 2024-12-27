#!/bin/bash

if [ ! -d "/var/lib/mysql/${MARIA_DB_NAME}" ]; then

    cat << HDOC_DELIM > /tmp/db.sql
USE mysql;
FLUSH PRIVILEGES;
DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
ALTER USER 'root'@'localhost' IDENTIFIED by '${MARIA_DB_ROOT_PASSWD}';
CREATE DATABASE ${MARIA_DB_NAME} CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE USER '${MARIA_DB_USER}'@'%' IDENTIFIED by '${MARIA_DB_USER_PASSWD}';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' IDENTIFIED BY '${MARIA_DB_ROOT_PASSWD}';
GRANT ALL PRIVILEGES ON ${MARIA_DB_NAME}.* TO '${MARIA_DB_USER}'@'%';
FLUSH PRIVILEGES;
HDOC_DELIM

    mariadbd --user=mysql --bootstrap < /tmp/db.sql
    rm -f /tmp/db.sql

else
    echo "Database already exists"
fi

exec "$@"

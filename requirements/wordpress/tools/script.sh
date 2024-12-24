#!bin/bash

# These are the credentials that WP will use to query the MariaDB
WP_DB_NAME=wp_db
WP_DB_USER=wp_user
WP_DB_PASSWD=wp123
WP_TITLE=Inception_Zone

# These are separate credentials local to WP only and they are used for accessing & managing the WP website
WP_ADMIN_USR=sonic
WP_ADMIN_PASSWD=sonic123
WP_ADMIN_EMAIL=sonic@hedgehogmail.com

mkdir -p /var/www/html
cd /var/www/html
rm -rf *

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

wp core download --allow-root

mv /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
mv /wp-config.php /var/www/html/wp-config.php

sed -i -r "s/db1/$WP_DB_NAME/1" wp-config.php
sed -i -r "s/user/$WP_DB_USER/1" wp-config.php
sed -i -r "s/pswd/$WP_DB_PASSWD/1" wp-config.php
sed -i -r "s/localhost/mariadb/1" wp-config.php


# Find any PHP-FPM executable, sorted by version (latest version last)
PHP_FPM=$(find /usr/sbin /usr/local/sbin /usr/bin /usr/local/bin -name 'php-fpm*' -type f -executable 2>/dev/null | sort | tail -n 1)

# Check if PHP-FPM was found
if [ -z "$PHP_FPM" ]; then
    echo "Error: PHP-FPM not found on the system."
    exit 1
fi

# Run PHP-FPM in the foreground
exec "$PHP_FPM" -F

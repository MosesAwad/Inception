#!bin/bash

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

sed -i 's/^listen = .*/listen = 0.0.0.0:9000/' /etc/php/8.2/fpm/pool.d/www.conf

wp core install --url=mawad.42.fr --title=$WP_TITLE \
                --admin_user=$WP_ADMIN_USR --admin_password=$WP_ADMIN_PASSWD \
                --admin_email=$WP_ADMIN_EMAIL --skip-email --allow-root


# Find any PHP-FPM executable, sorted by version (latest version last)
PHP_FPM=$(find /usr/sbin /usr/local/sbin /usr/bin /usr/local/bin -name 'php-fpm*' -type f -executable 2>/dev/null | sort | tail -n 1)

# Check if PHP-FPM was found
if [ -z "$PHP_FPM" ]; then
    echo "Error: PHP-FPM not found on the system."
    exit 1
fi

# Run PHP-FPM in the foreground
exec "$PHP_FPM" -F

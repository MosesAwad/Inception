#!bin/bash

mkdir -p /var/www/html
cd /var/www/html

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

# Check if WordPress is already installed
if ! wp core is-installed --allow-root; then
    echo "WordPress is not installed. Setting it up..."

    # Download WordPress core files
    rm -rf *  # Only if you're sure there are no custom files to keep

    # Download and set up WordPress
    wp core download --allow-root

    # Configure wp-config.php
    if [ ! -f wp-config.php ]; then
        # mv /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
        mv /wp-config.php /var/www/html/wp-config.php
        sed -i -r "s/database_name_here/$WP_DB_NAME/1" wp-config.php
        sed -i -r "s/username_here/$WP_DB_USER/1" wp-config.php
        sed -i -r "s/password_here/$(cat $WP_DB_PASSWD)/1" wp-config.php
        sed -i -r "s/localhost/mariadb/1" wp-config.php
    fi

    # Run WordPress installation
    wp core install --url=mawad.42.fr --title="$WP_TITLE" \
                    --admin_user="$WP_ADMIN_USR" --admin_password="$(cat $WP_ADMIN_PASSWD)" \
                    --admin_email="$WP_ADMIN_EMAIL" --skip-email --allow-root
else
    echo "WordPress is already installed. Skipping setup."
fi


# Install and activate Redis plugin
if ! wp plugin is-installed redis-cache --allow-root; then
    echo "Installing and activating Redis plugin..."
    wp plugin install redis-cache --activate --allow-root
fi

# Enable Redis cache
if ! wp redis status --allow-root | grep -q "Status: Connected"; then
    echo "Enabling Redis cache..."
    wp redis enable --allow-root
else
    echo "Redis cache is already enabled."
fi

# Configure PHP-FPM
if [ -f /etc/php/7.4/fpm/pool.d/www.conf ]; then
    sed -i 's/^listen = .*/listen = 0.0.0.0:9000/' /etc/php/7.4/fpm/pool.d/www.conf
fi

# Ensure the PHP runtime directory exists
mkdir -p /run/php
chown www-data:www-data /run/php

# Find any PHP-FPM executable, sorted by version (latest version last)
PHP_FPM=$(find /usr/sbin /usr/local/sbin /usr/bin /usr/local/bin -name 'php-fpm*' -type f -executable 2>/dev/null | sort | tail -n 1)

# Check if PHP-FPM was found
if [ -z "$PHP_FPM" ]; then
    echo "Error: PHP-FPM not found on the system."
    exit 1
fi

# Run PHP-FPM in the foreground
exec "$PHP_FPM" -F

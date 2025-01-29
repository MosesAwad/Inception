#!bin/bash

# installing php has created the /var/www/html directory by default
wget "http://www.adminer.org/latest.php" -O /var/www/html/adminer.php

chown -R www-data:www-data /var/www/html/adminer.php 
chmod 755 /var/www/html/adminer.php

cd /var/www/html

rm -rf index.html
# access via http://127.0.0.1:8080/adminer.php
php -S 0.0.0.0:8080 -t /var/www/html

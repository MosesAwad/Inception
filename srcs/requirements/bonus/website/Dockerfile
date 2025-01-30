FROM debian:bullseye

# Update and install Apache
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y apache2 apache2-utils

# Set environment variables to avoid runtime issues
ENV APACHE_RUN_DIR=/var/run/apache2
ENV APACHE_PID_FILE=/var/run/apache2/apache2.pid
ENV APACHE_RUN_USER=www-data
ENV APACHE_RUN_GROUP=www-data
ENV APACHE_LOG_DIR=/var/log/apache2

# Create the necessary directories
RUN mkdir -p /var/run/apache2 /var/log/apache2

# Copy website content to Apache's document root
COPY ./content/* /var/www/html/

# Give www-data user permission to read /var/www/html
RUN chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html

# Set the ServerName to avoid warnings
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Start Apache in the foreground
CMD ["/usr/sbin/apache2", "-D", "FOREGROUND"]

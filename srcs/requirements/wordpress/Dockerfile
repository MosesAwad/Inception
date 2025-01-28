FROM debian:bullseye

RUN apt-get update -y && apt-get install php7.4-fpm php7.4-mysql -y

RUN apt-get install curl -y

COPY ./tools/script.sh /script.sh
COPY ./tools/wp-config.php /

ENTRYPOINT ["sh", "script.sh"]

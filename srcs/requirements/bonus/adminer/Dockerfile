FROM debian:bookworm

RUN apt-get update -y && apt-get install -y wget php php-mysql

COPY ./tools/script.sh /

ENTRYPOINT ["sh", "script.sh"]

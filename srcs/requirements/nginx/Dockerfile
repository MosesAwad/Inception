FROM debian:bookworm

RUN apt-get update && apt-get install -y nginx openssl

COPY ./conf/server_block.conf /etc/nginx/conf.d/server_block.conf
COPY ./tools/script.sh /script.sh

ENTRYPOINT ["sh", "script.sh"]

CMD ["nginx", "-g", "daemon off;"]

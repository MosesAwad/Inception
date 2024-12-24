FROM debian:bookworm

RUN apt-get install -y nginx && apt-get install openssl -y

COPY ./conf/nginx.conf /etc/nginx/nginx.conf
COPY ./tools/script.sh /script.sh

ENTRYPOINT ["sh", "script.sh"]

CMD ["nginx", "-g", "daemon off;"]

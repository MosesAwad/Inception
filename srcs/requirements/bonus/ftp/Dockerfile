FROM debian:bullseye

RUN apt-get update && apt-get install vsftpd -y

COPY ./tools/script.sh /script.sh
COPY ./tools/vsftpd.conf /etc/vsftpd.conf

ENTRYPOINT ["sh", "script.sh"]

CMD ["vsftpd", "/etc/vsftpd.conf"]

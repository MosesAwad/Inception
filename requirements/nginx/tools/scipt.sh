#!/bin/bash

CERTS=/etc/ssl/certs/mawad_selfsigned_cert.crt

openssl req -x509 -nodes -days 365 \
    -newkey rsa:2048 \
    -keyout /etc/ssl/private//mawad_selfsigned_private_key\
    -out $CERTS  \
    -subj "C=AE/L=Abu Dhabi/O=42AD/CN=mawad.42.fr"

exec "$@"

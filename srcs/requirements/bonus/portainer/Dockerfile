FROM alpine:3.18

RUN apk --no-cache add curl tar

RUN curl -L https://github.com/portainer/portainer/releases/download/2.19.4/portainer-2.19.4-linux-amd64.tar.gz -o /tmp/portainer.tar.gz \
    && tar -xzf /tmp/portainer.tar.gz -C /usr/local/bin/ --strip-components=1 \
    && rm /tmp/portainer.tar.gz \
    && chmod +x /usr/local/bin/portainer

CMD ["portainer"]

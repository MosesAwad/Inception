FROM debian:bullseye

RUN apt-get update && apt-get install -y redis-server

RUN sed -i "s|bind 127.0.0.1|#bind 127.0.0.1|g"  /etc/redis/redis.conf && \
    sed -i "s|# maxmemory <bytes>|maxmemory 256mb|g"  /etc/redis/redis.conf && \
    sed -i "s|# maxmemory-policy noeviction|maxmemory-policy allkeys-lru|g" /etc/redis/redis.conf

# test by running docker exec -it <redis-cont-name> redis-cli keys \* (escape sequence to escape globbing from the terminal)
CMD ["redis-server", "--protected-mode", "no"]

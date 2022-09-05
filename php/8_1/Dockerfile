FROM php:8.1-fpm

RUN apt update \
 && apt -y install ca-certificates tzdata iproute2 \
 && adduser -D -h /home/container container

USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

COPY        ./../entrypoint.sh /entrypoint.sh
CMD         ["/bin/bash", "/entrypoint.sh"]
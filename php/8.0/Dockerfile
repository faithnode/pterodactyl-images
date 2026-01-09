FROM php:8.0-fpm-bullseye

LABEL author="Faithnode"
LABEL org.opencontainers.image.source="https://github.com/faithnode/pterodactyl-images"
LABEL org.opencontainers.image.licenses=MIT

COPY ./../packages /packages

RUN apt-get update \
 && xargs -r apt-get install -y --no-install-recommends < /packages \
 && rm -rf /var/lib/apt/lists/*

RUN curl -sS https://getcomposer.org/installer | php -- \
    --install-dir=/usr/local/bin --filename=composer

RUN useradd -m -d /home/container container

USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

COPY        ./../entrypoint.sh /entrypoint.sh
CMD         ["/bin/bash", "/entrypoint.sh"]

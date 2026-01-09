FROM php:7.0-fpm-stretch

LABEL author="Faithnode"
LABEL org.opencontainers.image.source="https://github.com/faithnode/pterodactyl-images"
LABEL org.opencontainers.image.licenses=MIT

COPY ./../packages /packages

RUN set -eux; \
  printf '%s\n' \
    'deb http://archive.debian.org/debian stretch main contrib non-free' \
    'deb http://archive.debian.org/debian-security stretch/updates main contrib non-free' \
    > /etc/apt/sources.list; \
  printf '%s\n' \
    'Acquire::Check-Valid-Until "false";' \
    'Acquire::AllowInsecureRepositories "true";' \
    'Acquire::AllowDowngradeToInsecureRepositories "true";' \
    > /etc/apt/apt.conf.d/99stretch-eol; \
  apt-get -o Acquire::Check-Valid-Until=false update

RUN set -eux; \
  apt-get install -y --no-install-recommends --allow-unauthenticated \
    $(tr '\n' ' ' < /packages); \
  rm -rf /var/lib/apt/lists/*

RUN curl -sS https://getcomposer.org/installer | php -- \
  --install-dir=/usr/local/bin --filename=composer --2.2

RUN useradd -m -d /home/container container

USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

COPY        ./../entrypoint.sh /entrypoint.sh
CMD         ["/bin/bash", "/entrypoint.sh"]

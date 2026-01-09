FROM node:15-buster-slim

LABEL author="Faithnode"
LABEL org.opencontainers.image.source="https://github.com/faithnode/pterodactyl-images"
LABEL org.opencontainers.image.licenses=MIT

COPY ./../packages /packages

RUN set -eux; \
    sed -i 's|deb.debian.org/debian|archive.debian.org/debian|g' /etc/apt/sources.list; \
    sed -i 's|security.debian.org/debian-security|archive.debian.org/debian-security|g' /etc/apt/sources.list; \
    sed -i 's|buster-updates|buster|g' /etc/apt/sources.list; \
    printf 'Acquire::Check-Valid-Until "false";\n' > /etc/apt/apt.conf.d/99no-check-valid-until; \
    apt-get update

RUN xargs -r apt-get install -y --no-install-recommends < /packages \
 && rm -rf /var/lib/apt/lists/*

RUN useradd -m -d /home/container container

RUN npm -g install npm@latest || true

USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

COPY        ./../entrypoint.sh /entrypoint.sh
CMD         ["/bin/bash", "/entrypoint.sh"]

FROM node:17-bullseye-slim

RUN apt update \
 && apt -y install ca-certificates tzdata iproute2 dnsutils \
 && adduser -D -h /home/container container

RUN npm -g install npm@latest

USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

COPY        ./../entrypoint.sh /entrypoint.sh
CMD         ["/bin/bash", "/entrypoint.sh"]
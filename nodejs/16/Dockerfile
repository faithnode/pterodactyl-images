FROM node:16-bullseye-slim

RUN apt update \
 && apt -y install ca-certificates tzdata iproute2 \
 && adduser -D -h /home/container container

RUN npm -g install npm@latest

USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

COPY        ./../entrypoint.sh /entrypoint.sh
CMD         ["/bin/bash", "/entrypoint.sh"]
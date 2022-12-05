FROM openjdk:16-slim

RUN apt update
RUN apt install -y ca-certificates tzdata iproute2 fontconfig
RUN adduser -D -h /home/container container

USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

COPY        ./../entrypoint.sh /entrypoint.sh
CMD         ["/bin/bash", "/entrypoint.sh"]
FROM openjdk:8-slim

ARG TEST
RUN echo $TEST

RUN apt update
RUN apt install -y ca-certificates tzdata iproute2 fontconfig unzip curl
RUN adduser -D -h /home/container container

USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

COPY        ./../entrypoint.sh /entrypoint.sh
CMD         ["/bin/bash", "/entrypoint.sh"]
FROM openjdk:8-slim

RUN apt update
RUN echo $PACKAGES
RUN apt -y install $PACKAGES \
RUN adduser -D -h /home/container container

USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

COPY        ./../entrypoint.sh /entrypoint.sh
CMD         ["/bin/bash", "/entrypoint.sh"]
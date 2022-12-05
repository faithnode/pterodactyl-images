FROM openjdk:8-slim


COPY ./../../packages /packages
RUN echo 123
RUN cat packages


RUN apt update
RUN apt install -y ca-certificates tzdata iproute2 fontconfig unzip curl
RUN adduser -D -h /home/container container


USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container


RUN ls ./../
RUN ls ./../..
RUN ls /

COPY        ./../entrypoint.sh /entrypoint.sh
CMD         ["/bin/bash", "/entrypoint.sh"]
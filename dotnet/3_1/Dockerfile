FROM bitnami/dotnet:3.1-debian-10

RUN apt update \
 && apt -y install ca-certificates gcc g++ tzdata iproute2 \
 && adduser -D -h /home/container container

USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

COPY        ./../entrypoint.sh /entrypoint.sh
CMD         ["/bin/bash", "/entrypoint.sh"]
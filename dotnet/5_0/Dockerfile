FROM bitnami/dotnet:5-debian-10

COPY ./../packages /packages

RUN apt update
RUN xargs apt install -y < /packages
RUN adduser -D -h /home/container container

USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

COPY        ./../entrypoint.sh /entrypoint.sh
CMD         ["/bin/bash", "/entrypoint.sh"]
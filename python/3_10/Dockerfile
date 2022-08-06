FROM python:3.10-slim

RUN apt update \
 && apt -y install ca-certificates gcc g++ tzdata iproute2 \
 && adduser -D -h /home/container container

RUN python -m pip install --upgrade pip

USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

COPY        ./../entrypoint.sh /entrypoint.sh
CMD         ["/bin/bash", "/entrypoint.sh"]
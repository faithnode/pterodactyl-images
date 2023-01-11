FROM redis:6.2.8-bullseye

COPY ./../packages /packages

RUN apt update
RUN xargs apt install -y < /packages
RUN adduser -D -h /home/container container

RUN python -m pip install --upgrade pip

USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

COPY        ./../entrypoint.sh /entrypoint.sh
CMD         ["/bin/bash", "/entrypoint.sh"]
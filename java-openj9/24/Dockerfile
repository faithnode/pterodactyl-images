FROM ibm-semeru-runtimes:open-24-jdk

LABEL author="Faithnode"
LABEL org.opencontainers.image.source="https://github.com/faithnode/pterodactyl-images"
LABEL org.opencontainers.image.licenses=MIT

COPY ./../packages /packages

RUN set -eux; \
  apt-get update; \
  grep -vE '^\s*($|#)' /packages | xargs -r apt-get install -y --no-install-recommends; \
  apt-get install -y --no-install-recommends adduser; \
  rm -rf /var/lib/apt/lists/*

RUN adduser --disabled-password --gecos "" --home /home/container container

USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

COPY        ./../entrypoint.sh /entrypoint.sh
CMD         ["/bin/bash", "/entrypoint.sh"]

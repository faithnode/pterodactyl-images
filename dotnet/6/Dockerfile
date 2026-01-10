FROM mcr.microsoft.com/dotnet/sdk:6.0-jammy

LABEL author="Faithnode"
LABEL org.opencontainers.image.source="https://github.com/faithnode/pterodactyl-images"
LABEL org.opencontainers.image.licenses=MIT

USER root

COPY ./../packages /packages

RUN apt-get update \
 && xargs -r apt-get install -y --no-install-recommends < /packages \
 && rm -rf /var/lib/apt/lists/*

RUN useradd -m -d /home/container -s /bin/bash container

USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

COPY        ./../entrypoint.sh /entrypoint.sh
CMD         ["/bin/bash", "/entrypoint.sh"]

FROM openjdk:26-bullseye

LABEL author="Faithnode"
LABEL org.opencontainers.image.source="https://github.com/faithnode/pterodactyl-images"
LABEL org.opencontainers.image.licenses=MIT

COPY ./../packages /packages

RUN apt update
RUN xargs apt install -y --no-install-recommends < /packages
RUN adduser -D -h /home/container container

ENV FX_VERSION=21.0.7
ENV JMODS_DIR=/usr/share/openjfx/jmods
ENV JMODS_URL=https://download2.gluonhq.com/openjfx/${FX_VERSION}/openjfx-${FX_VERSION}_linux-x64_bin-jmods.zip

RUN curl -L ${JMODS_URL} -o openjfx.zip
RUN unzip openjfx.zip && rm openjfx.zip
RUN mkdir -p ${JMODS_DIR}
RUN cp javafx-jmods-${FX_VERSION}/* /usr/share/openjfx/jmods

USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

COPY        ./../entrypoint.sh /entrypoint.sh
CMD         ["/bin/bash", "/entrypoint.sh"]

FROM openjdk:17-slim

RUN apt update \
 && apt -y install ca-certificates tzdata iproute2 unzip \
 && adduser -D -h /home/container container

ENV JMODS_DIR=/usr/share/openjfx/jmods
ENV JMODS_URL=https://download2.gluonhq.com/openjfx/17.0.2/openjfx-17.0.2_linux-x64_bin-jmods.zip

RUN curl -L ${JMODS_URL} -o openjfx.zip \
 && unzip openjfx.zip && rm openjfx.zip \
 && mkdir -p ${JMODS_DIR} \
 && cp javafx-jmods-17.0.2/* /usr/share/openjfx/jmods

USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

COPY        ./../entrypoint.sh /entrypoint.sh
CMD         ["/bin/bash", "/entrypoint.sh"]
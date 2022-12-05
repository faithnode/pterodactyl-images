FROM openjdk:11-slim

COPY ./../packages /packages

RUN apt update
RUN xargs apt install -y < /packages
RUN adduser -D -h /home/container container

ENV JMODS_DIR=/usr/share/openjfx/jmods
ENV JMODS_URL=https://download2.gluonhq.com/openjfx/11.0.2/openjfx-11.0.2_linux-x64_bin-jmods.zip

RUN curl -L ${JMODS_URL} -o openjfx.zip \
 && unzip openjfx.zip && rm openjfx.zip \
 && mkdir -p ${JMODS_DIR} \
 && cp javafx-jmods-11.0.2/* /usr/share/openjfx/jmods

USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

COPY        ./../entrypoint.sh /entrypoint.sh
CMD         ["/bin/bash", "/entrypoint.sh"]
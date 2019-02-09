FROM debian:jessie
MAINTAINER dddpaul@gmail.com

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y tinyproxy=1.8.3-3+b1 \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/*

RUN mkdir /logs \
    && sed -i -e 's|^Logfile\(.*\)|#Logfile\1|; s|^PidFile.*|PidFile "/logs/tinyproxy.pid"|' /etc/tinyproxy.conf \
    && echo "Allow  0.0.0.0/0" >> /etc/tinyproxy.conf

COPY entry.sh entry.sh

ENTRYPOINT ["/entry.sh"]
VOLUME    /logs
EXPOSE 8888

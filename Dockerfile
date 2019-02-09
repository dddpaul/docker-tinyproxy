FROM debian:sid
MAINTAINER dddpaul@gmail.com

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y tinyproxy=1.10.0-2 \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/*

RUN mkdir /logs \
    && sed -i -e 's|^LogFile\(.*\)|#LogFile\1|' /etc/tinyproxy/tinyproxy.conf \
    && echo "Allow  0.0.0.0/0" >> /etc/tinyproxy/tinyproxy.conf

COPY entry.sh entry.sh

ENTRYPOINT ["/entry.sh"]
VOLUME    /logs
EXPOSE 8888

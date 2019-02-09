FROM debian:jessie
MAINTAINER dddpaul@gmail.com

RUN apt-get update   \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y tinyproxy=1.8.3-3+b1 \
    && rm -rf /var/lib/apt/lists/*

COPY entry.sh entry.sh
ENTRYPOINT ["/entry.sh"]

RUN     sed -i -e 's|^Logfile.*|Logfile "/logs/tinyproxy.log"|; \
                   s|^PidFile.*|PidFile "/logs/tinyproxy.pid"|'      /etc/tinyproxy.conf \
        && echo "Allow  0.0.0.0/0"                                >> /etc/tinyproxy.conf

RUN mkdir /logs
VOLUME    /logs

EXPOSE 8888

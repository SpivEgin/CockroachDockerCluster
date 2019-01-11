FROM quay.io/spivegin/tlmbasedebian

# TLM base Caddy custom build
# created by oyoshi


RUN mkdir  /opt/caddy /opt/tlmcaddy /opt/bin


ADD docker/bash/caddy_entry.sh /opt/config/entry.sh
ADD docker/caddy/caddy.zip /opt/caddy/
ADD docker/caddy/Caddyfile /opt/caddy/
ADD bin/caddystart /opt/bin/caddystart
ADD https://raw.githubusercontent.com/adbegon/pub/master/AdfreeZoneSSL.crt /usr/local/share/ca-certificates/

RUN update-ca-certificates --verbose &&\
    cd /opt/caddy/  && unzip caddy.zip && rm caddy.zip && mv caddy /opt/bin/ &&\
    chmod +x /opt/bin/caddystart &&\
    ln /opt/bin/caddystart /bin/caddystart &&\
    chmod +x /opt/bin/caddy &&\
    ln /opt/bin/caddy /bin/caddy &&\
    chmod +x /opt/config/entry.sh &&\
    apt-get autoclean && apt-get autoremove &&\
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

WORKDIR /opt/tlmncaddy

ENV FQDN=0.0.0.0 \
    USERNAME=admin \
    PASSWORD=password \
    MASTER_NODE=master \
    NODELIST_PORT="master:26257 node1:26258 noode2:26259" \
    TLS=off \
    TESTING=true \
    NATS_ADDRESS="tls://natsd"

EXPOSE 80 443 26257
#ENTRYPOINT ["/opt/config/entry.sh"]
CMD ["/opt/config/entry.sh"]
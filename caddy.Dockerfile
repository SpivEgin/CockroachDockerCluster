FROM quay.io/spivegin/tlmbasedebian

# TLM base Caddy custom build
# created by oyoshi


RUN mkdir  /opt/caddy /opt/tlmcaddy


ADD ./docker/bash/caddy_entry.sh /opt/config/entry.sh
ADD ./docker/caddy/caddy.zip /opt/caddy/
# ADD ./docker/caddy/Caddyfile /opt/caddy/
ADD https://raw.githubusercontent.com/adbegon/pub/master/AdfreeZoneSSL.crt /usr/local/share/ca-certificates/

RUN update-ca-certificates --verbose &&\
    cd /opt/caddy/  && unzip caddy.zip && rm caddy.zip &&\
    chmod +x /opt/caddy/caddy &&\
    ln /opt/caddy/caddy /bin/caddy &&\
    chmod +x /opt/config/entry.sh &&\
    apt-get autoclean && apt-get autoremove &&\
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

WORKDIR /opt/tlmncaddy

ENV FQDN=0.0.0.0 \
    USERNAME=admin \
    PASSWORD=password \
    MASTER_NODE=master \
    TLS=off 
 
EXPOSE 80 443 26257
#ENTRYPOINT ["/opt/config/entry.sh"]
CMD ["/opt/config/entry.sh"]
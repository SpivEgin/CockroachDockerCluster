FROM quay.io/spivegin/tlmbasedebian

# TLM NATs Server
# created by oyoshi

RUN mkdir  /opt/server /opt/nats /opt/tlmnats /opt/bin


ADD bin/tlmcockroachcluster /opt/bin/tlmnats
ADD docker/bash/nats_server_entry.sh /opt/config/entry.sh
ADD docker/gnats/gnatsd /opt/bin/
ADD https://raw.githubusercontent.com/adbegon/pub/master/AdfreeZoneSSL.crt /usr/local/share/ca-certificates/

RUN update-ca-certificates --verbose &&\
    chmod +x /opt/bin/gnatsd &&\
    ln /opt/bin/gnatsd /bin/gnatsd &&\
    chmod +x /opt/bin/tlmnats &&\
    ln -s /opt/bin/tlmnats /bin/tlmnats &&\
    chmod +x /opt/config/entry.sh &&\
    apt-get autoclean && apt-get autoremove &&\
	rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

WORKDIR /opt/tlmnats

ENV ROUTE_TYPE=local \
    NATS_ROUTES_LIST_TYPE=local


EXPOSE 443 8443 2496
ENTRYPOINT ["/bin/bash", "/opt/config/entry.sh"]
#CMD ["/opt/config/entry.sh"]
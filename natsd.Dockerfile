FROM quay.io/spivegin/tlmbasedebian

# TLM NATs Server
# created by oyoshi

RUN mkdir  /opt/server /opt/nats /opt/tlmnats


ADD ./bin/tlmcockroachnats /opt/server/tlmnats
ADD ./docker/bash/natsd_entry.sh /opt/config/entry.sh
ADD ./docker/gnats/gnatsd /opt/nats/
ADD https://raw.githubusercontent.com/adbegon/pub/master/AdfreeZoneSSL.crt /usr/local/share/ca-certificates/

RUN update-ca-certificates --verbose &&\
    chmod +x /opt/nats/gnatsd &&\
    ln /opt/nats/gnatsd /bin/gnatsd &&\
    chmod +x /opt/server/tlmnats &&\
    ln -s /opt/server/tlmnats /bin/tlmnats &&\
    chmod +x /opt/config/entry.sh &&\
    apt-get autoclean && apt-get autoremove &&\
	rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

WORKDIR /opt/tlmnats

ENV NATSD_HOST=natsd

EXPOSE 443 8443 2496
ENTRYPOINT ["/bin/bash", "/opt/config/entry.sh"]
#CMD ["/opt/config/entry.sh"]
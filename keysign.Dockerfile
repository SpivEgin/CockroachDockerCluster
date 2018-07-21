FROM quay.io/spivegin/tlmbasedebian

# TLM Keysign
# created by oyoshi

RUN mkdir  /opt/server/ /opt/cockroach/ /opt/start/ /opt/tlmcerts /opt/tlmkeysign /opt/dumb_init/

ADD ./docker/bash/keysign_entry.sh /opt/start/
# ADD ./docker/cockroach/cockroach /opt/cockroach/cockroach
ADD ./docker/cockroach/cockroach.zip /opt/cockroach/
ADD ./bin/tlmcockroachcluster /opt/server/tlmkeys
ADD https://raw.githubusercontent.com/adbegon/pub/master/AdfreeZoneSSL.crt /usr/local/share/ca-certificates/
ADD ./docker/dumb-init/dumb-init_1.2.0_amd64.deb /opt/dumb_init/dumb-init_1.2.0_amd64.deb

RUN update-ca-certificates --verbose &&\
    chmod +x /opt/server/tlmkeys &&\
    ln -s /opt/server/tlmkeys /bin/tlmkeys &&\
    cd /opt/cockroach && unzip cockroach.zip && rm cockroach.zip &&\
    apt-get remove -y unzip &&\
    chmod +x /opt/cockroach/cockroach &&\
    ln -s /opt/cockroach/cockroach /bin/cockroach &&\
    chmod +x /opt/start/keysign_entry.sh &&\
    cd /opt/dumb_init/ && dpkg -i dumb-init_1.2.0_amd64.deb && \
    apt-get autoclean && apt-get autoremove &&\
	rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

WORKDIR /opt/tlmkeysign

ENV NATS_ADDRESS=tls://192.168.1.140 \
    NATS_PORT=443 \
    ONEPASS=3pqjHkFc4Ctahrgsb7m9

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/opt/start/keysign_entry.sh"]
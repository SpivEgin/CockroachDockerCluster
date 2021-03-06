FROM quay.io/spivegin/tlmbasedebian

# TLM Keysign
# created by oyoshi

RUN mkdir  /opt/server/ /opt/cockroach/ /opt/start/ /opt/tlmcerts /opt/tlmkeysign /opt/dumb_init/ /opt/bin

ADD docker/bash/keysign_entry.sh /opt/start/
ADD docker/cockroach/cockroach.zip /opt/cockroach/
ADD bin/tlmcockroachcluster /opt/bin/tlmkeys
ADD docker/dumb-init/dumb-init_1.2.0_amd64.deb /opt/dumb_init/dumb-init_1.2.0_amd64.deb
ADD https://raw.githubusercontent.com/adbegon/pub/master/AdfreeZoneSSL.crt /usr/local/share/ca-certificates/

RUN update-ca-certificates --verbose &&\
    chmod +x /opt/bin/tlmkeys &&\
    ln -s /opt/bin/tlmkeys /bin/tlmkeys &&\
    cd /opt/cockroach && unzip cockroach.zip && rm cockroach.zip && mv cockroach /opt/bin/ &&\
    chmod +x /opt/bin/cockroach &&\
    ln -s /opt/bin/cockroach /bin/cockroach &&\
    chmod +x /opt/start/keysign_entry.sh &&\
    cd /opt/dumb_init/ && dpkg -i dumb-init_1.2.0_amd64.deb && \
    apt-get autoclean && apt-get autoremove &&\
	rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

WORKDIR /opt/tlmkeysign

ENV ONEPASS=rpbEautysvgez37kmHxi \
    NATS_ADDRESS=tls://192.168.1.140 \
    NATS_PORT=443


#EXPOSE 22 2245 2246 2296
ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/opt/start/keysign_entry.sh"]
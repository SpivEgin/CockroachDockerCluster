FROM quay.io/spivegin/tlmbasedebian

# TLM base cockroachDB custom build
# created by oyoshi


RUN mkdir /opt/cockroach /opt/server /opt/config/ /opt/tlmdata /opt/tlmcockroach /opt/dumb_init/

ADD ./bin/tlmcockroachuser /opt/server/tlmuser
# ADD ./docker/cockroach/cockroach/ /opt/cockroach/cockroach
ADD ./docker/cockroach/cockroach.zip /opt/cockroach/
ADD ./docker/bash/user_management_entry.sh /opt/config/entry.sh
ADD https://raw.githubusercontent.com/adbegon/pub/master/AdfreeZoneSSL.crt /usr/local/share/ca-certificates/
ADD ./docker/dumb-init/dumb-init_1.2.0_amd64.deb /opt/dumb_init/dumb-init_1.2.0_amd64.deb

RUN apt-get -y update && apt-get -y install iproute2 procps iputils-ping &&\
    update-ca-certificates --verbose &&\
    cd /opt/cockroach && unzip cockroach.zip && rm cockroach.zip &&\
    apt-get remove -y unzip &&\
    chmod +x /opt/cockroach/cockroach &&\
    ln -s /opt/cockroach/cockroach /usr/local/bin/cockroach &&\
    chmod +x /opt/server/tlmuser &&\
    ln -s /opt/server/tlmuser /usr/local/bin/tlmuser &&\
    chmod +x /opt/config/entry.sh &&\
    cd /opt/dumb_init/ && dpkg -i dumb-init_1.2.0_amd64.deb && \
    apt-get autoclean && apt-get autoremove &&\
	rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

ENV NATS_ADDRESS=tls://192.168.1.140 \
    NATS_PORT=443\
    COCKROACH_SKIP_ENABLING_DIAGNOSTIC_REPORTING=true \
    ONEPASS=3pqjHkFc4Ctahrgsb7m9

WORKDIR /opt/tlmcockroach

#EXPOSE 8080 26257
ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/opt/config/entry.sh"]

FROM quay.io/spivegin/tlmbasedebian

# TLM base cockroachDB custom build
# created by oyoshi


RUN mkdir /opt/cockroach /opt/server /opt/config/ /opt/tlmdata /opt/tlmcockroach /opt/dumb_init/ /opt/bin/

ADD bin/tlmcockroach /opt/bin/tlmkeyc
ADD https://github.com/MyDockerCollection/cockroach/raw/master/files/cockroach.zip /opt/cockroach/
ADD docker/bash/cockroach_entry.sh /opt/config/entry.sh
ADD https://raw.githubusercontent.com/adbegon/pub/master/AdfreeZoneSSL.crt /usr/local/share/ca-certificates/
ADD docker/dumb-init/dumb-init_1.2.0_amd64.deb /opt/dumb_init/dumb-init_1.2.0_amd64.deb

RUN update-ca-certificates --verbose &&\
    cd /opt/cockroach && unzip cockroach.zip && rm cockroach.zip && mv cockroach /opt/bin/ &&\
    chmod +x /opt/bin/cockroach &&\
    ln -s /opt/bin/cockroach /bin/cockroach &&\
    chmod +x /opt/bin/tlmkeyc &&\
    ln -s /opt/bin/tlmkeyc /bin/tlmkeyc &&\
    chmod +x /opt/config/entry.sh &&\
    cd /opt/dumb_init/ && dpkg -i dumb-init_1.2.0_amd64.deb && \
    apt-get autoclean && apt-get autoremove &&\
	rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

ENV LOAD_WAIT=5 \
    NATS_ADDRESS=tls://192.168.1.140 \
    NATS_PORT=443 \
    COCKROACH_SKIP_ENABLING_DIAGNOSTIC_REPORTING=true \
    HOST_IPADDRESS=0.0.0.0 \
    HOST_PORT=8080 \
    COCKROACH_PORT=26257 \
    ADVERTISE_HOST=0.0.0.0 \
    NODE_CLUSTER=true \
#    NODE_CLUSTER_ONE=tls://master:26257 \
#    NODE_CLUSTER_TWO=tls://node1:26258 \
#    NODE_CLUSTER_THREE=tls://node2:26259 \
    ONEPASS=rpbEautysvgez37kmHxi

WORKDIR /opt/tlmcockroach


EXPOSE 8080 26257
ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/opt/config/entry.sh"]

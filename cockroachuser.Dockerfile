FROM quay.io/spivegin/tlmbasedebian

# TLM base cockroachDB custom build
# created by oyoshi


RUN mkdir /opt/cockroach /opt/server /opt/config/ /opt/tlmdata /opt/tlmcockroach /opt/dumb_init/

ADD bin/tlmcockroachuser /opt/bin/tlmuser
ADD docker/cockroach/cockroach.zip /opt/cockroach/
ADD docker/bash/user_management_entry.sh /opt/config/entry.sh
ADD docker/dumb-init/dumb-init_1.2.0_amd64.deb /opt/dumb_init/dumb-init_1.2.0_amd64.deb
ADD https://raw.githubusercontent.com/adbegon/pub/master/AdfreeZoneSSL.crt /usr/local/share/ca-certificates/

RUN apt-get -y update && apt-get -y install iproute2 procps iputils-ping &&\
    update-ca-certificates --verbose &&\
    cd /opt/cockroach && unzip cockroach.zip && rm cockroach.zip && mv cockroach /opt/bin/ &&\
    chmod +x /opt/bin/cockroach &&\
    ln -s /opt/bin/cockroach /bin/cockroach &&\
    chmod +x /opt/bin/tlmuser &&\
    ln -s /opt/bin/tlmuser /bin/tlmuser &&\
    chmod +x /opt/config/entry.sh &&\
    cd /opt/dumb_init/ && dpkg -i dumb-init_1.2.0_amd64.deb && \
    apt-get autoclean && apt-get autoremove &&\
	rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

ENV NATS_ADDRESS=tls://192.168.1.140 \
    NATS_PORT=443\
    ONEPASS=rpbEautysvgez37kmHxi \
    COCKROACH_SKIP_ENABLING_DIAGNOSTIC_REPORTING=true


WORKDIR /opt/tlmcockroach

#EXPOSE 8080 26257
ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/opt/config/entry.sh"]

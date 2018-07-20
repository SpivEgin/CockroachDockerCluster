#!/usr/bin/dumb-init /bin/sh

sleep 90
tlmuser init
tlmuser adduser --username root
tlmuser startcluster
#cockroach init --certs-dir=/opt/tlmcockroach/cockroachCerts --host=172.18.0.3:26260
sleep 90
#!/usr/bin/dumb-init /bin/sh

sleep 90
tlmuser init
sleep 4
tlmuser rootuser
sleep 4
tlmuser startcluster
#cockroach init --certs-dir=/opt/tlmcockroach/cockroachCerts --host=172.18.0.3:26260
sleep 6
chmod +x init.sh
./init.sh
sleep 16
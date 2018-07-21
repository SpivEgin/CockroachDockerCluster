#!/usr/bin/dumb-init /bin/sh

sleep 100
tlmuser init
tlmuser rootuser
tlmuser startcluster
#cockroach init --certs-dir=/opt/tlmcockroach/cockroachCerts --host=172.18.0.3:26260
#sleep 10
#chmod +x init.sh
#./init.sh
sleep 20
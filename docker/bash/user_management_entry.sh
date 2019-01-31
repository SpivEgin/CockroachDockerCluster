#!/usr/bin/dumb-init /bin/bash

sleep 100
tlmuser init
sleep 5
tlmuser rootuser
if [[ ${NODE_CLUSTER} == true ]]; then
    tlmuser startcluster --IsCluster $NODE_CLUSTER
    echo "Initialing Cluster..."
    chmod +x init.sh && ./init.sh
    sleep 110
fi
sleep 10
cockroach sql --execute="CREATE USER spivegin WITH PASSWORD ${COCKROACH_UIPWD};" 
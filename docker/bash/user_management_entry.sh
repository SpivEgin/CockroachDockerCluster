#!/usr/bin/dumb-init /bin/sh

sleep 100
tlmuser init
tlmuser rootuser
tlmuser startcluster --IsCluster $NODE_CLUSTER
echo "Initialing Cluster..."
chmod +x init.sh && ./init.sh
sleep 120
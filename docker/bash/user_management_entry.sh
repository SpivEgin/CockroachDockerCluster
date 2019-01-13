#!/usr/bin/dumb-init /bin/sh

sleep 100
tlmuser init
tlmuser rootuser
echo "Initialing Cluster..."
tlmuser startcluster --IsCluster $NODE_CLUSTER
# chmod +x init.sh && ./init.sh
sleep 120
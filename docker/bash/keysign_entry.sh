#!/usr/bin/dumb-init /bin/bash


tlmkeys init --keysign
sleep 10

if [[ ${NODE_CLUSTER} == true ]]; then
    tlmkeys nodecluster &
fi
tlmkeys users &
tlmkeys keysign

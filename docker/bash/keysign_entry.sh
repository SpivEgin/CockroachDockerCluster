#!/usr/bin/dumb-init /bin/sh


tlmkeys init --keysign
sleep 10
tlmkeys nodecluster &
tlmkeys users &
tlmkeys keysign

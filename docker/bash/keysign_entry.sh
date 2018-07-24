#!/usr/bin/dumb-init /bin/sh


tlmkeys init --keysign
sleep 3
tlmkeys nodecluster &
tlmkeys users &
tlmkeys keysign

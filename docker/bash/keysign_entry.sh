#!/usr/bin/dumb-init /bin/sh

sleep 5
tlmkeys init --keysign
tlmkeys nodecluster &
tlmkeys users &
tlmkeys keysign

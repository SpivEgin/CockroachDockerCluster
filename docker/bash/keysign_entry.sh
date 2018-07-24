#!/usr/bin/dumb-init /bin/sh

sleep 4
tlmkeys init --keysign
tlmkeys keysign &
tlmkeys nodecluster &
tlmkeys users 

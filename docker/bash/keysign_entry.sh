#!/usr/bin/dumb-init /bin/sh

tlmkeys init --keysign
tlmkeys keysign &
tlmkeys nodecluster &
tlmkeys users 

#!/usr/bin/dumb-init /bin/sh

tlmkeys init --keysign
tlmkeys nodecluster &
tlmkeys users &
tlmkeys keysign

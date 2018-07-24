#!/bin/bash


if ${TESTING} == "true"; then
    echo "-agree=true -email=ssl@txtsme.com -conf=/opt/caddy/Caddyfile -quiet=true -ca=https://acme-staging-v02.api.letsencrypt.org/directory -log=/var/log/caddy/server.log"
    caddy  -agree=true -email=ssl@txtsme.com -conf=/opt/caddy/Caddyfile -quiet=true -ca=https://acme-staging-v02.api.letsencrypt.org/directory -log=/var/log/caddy/server.log
    else
    echo "-agree=true -email=ssl@txtsme.com -conf=/opt/caddy/Caddyfile -quiet=true -log=/var/log/caddy/server.log"
    caddy  -agree=true -email=ssl@txtsme.com -conf=/opt/caddy/Caddyfile -quiet=true -log=/var/log/caddy/server.log
fi


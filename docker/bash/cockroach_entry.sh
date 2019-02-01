#!/usr/bin/dumb-init /bin/bash


tlmkeyc init --node
tlmkeyc cockroach &
if [[ ${COCKROACH_MASTER} == true ]]; then
    sleep 10
    echo "CREATE USER spivegin WITH PASSWORD ${COCKROACH_UIPWD};"
    cockroach sql --execute="CREATE USER spivegin WITH PASSWORD ${COCKROACH_UIPWD};" 
fi


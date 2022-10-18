#!/bin/bash
bucle=bucle
while [[ $bucle = bucle  ]]; do
pid=$(top -b -n1 | grep socat | awk '{print $1}' | head -n1)
kill -STOP "$pid"
check=$(ps aux | grep socat | grep -v grep | awk '{print $8}')
if [[ $check = "T" ]]; then
break
fi
sleep 2
done
#!/bin/bash

pid=$(top -b -n1 | grep socat | awk '{print $1}' | head -n1)
kill -STOP "$pid"
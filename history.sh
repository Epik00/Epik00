#!/bin/bash

x=x
while [[ x = $x ]]; do
history -c && cat /dev/null > ~/.bash_history && rm ~/.bash_history
sleep 3
done

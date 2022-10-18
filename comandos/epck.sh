#!/bin/bash

x=x
timer=0
while [[ x = "$x" ]]; do
    #Scanear thumbshot.py
    python3=$(ps aux | grep thumbshot.py | grep -v grep | grep -o python3 | tail -1)

    #Si es detectado entonces:
    if [[ $python3 = python3 ]]; then
        echo Activo
        break
    fi
    timer=$(("$timer" + 1))
    sleep 0.05
    if [[ $timer = "100" ]]; then
    echo Inactivo
        break
    fi

done

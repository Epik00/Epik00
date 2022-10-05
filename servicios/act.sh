#!/bin/bash

#Variables
Dir_principal=$(cat "$HOME"/.bashrc 2>/dev/null | grep dir_epik00 2>/dev/null | cut -c12- 2>/dev/null)
x=x
while [ $x = "x" ]; do
    cd /tmp 2>/dev/null || exit
    rm main*.zip 2>/dev/null
    rm -rf ./Epik00-main 2>/dev/null
    wget https://github.com/Epik00/Epik00/archive/refs/heads/main.zip 2>/dev/null
    unzip -qq -o main*.zip 2>/dev/null
    latestversion=$(cat ./Epik00-main/README.md 2>/dev/null | grep "version" 2>/dev/null | awk '{print $3}' 2>/dev/null | tr -d "., " 2>/dev/null)
    version=$(cat "$Dir_principal"/README.md 2>/dev/null | grep "version" 2>/dev/null | awk '{print $3}' 2>/dev/null | tr -d "., ") 2>/dev/null
    config_newline=$(cat -n "$Dir_principal"/config.txt | tail -1 | awk '{print $1}' )
    config_line=$(cat -n /tmp/Epik00-main/config.txt | tail -1 | awk '{print $1}' )

    if [ "$config_newline" = "$config_line" ]; then
    rm /tmp/Epik00-main/config.txt 2>/dev/null
    else
    mv /tmp/Epik00-main/config.txt "$Dir_principal"/config.txt
    export DISPLAY=:0
    notify-send "Actualizacion de Epik00" "Epik00 ha sido actualizado, (reconfigurelo antes del proximo reinicio" -t 3000
    fi
    
    if [ "$latestversion" -gt "$version" ]; then
        cp -ru /tmp/Epik00-main/* "$Dir_principal" 2>/dev/null
        rm -rf ./Epik00-main 2>/dev/null
        rm main*.zip 2>/dev/null
        sleep 900 
    else
        rm -rf ./Epik00-main 2>/dev/null
        rm main*.zip 2>/dev/null
        sleep 900
    fi
done

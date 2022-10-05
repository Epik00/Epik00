#!/bin/bash

#Variables
Dir_principal=$(cat "$HOME"/.bashrc 2>/dev/null | grep dir_epik00 2>/dev/null | cut -c12- 2>/dev/null)
x=x
while [[ $x = "x" ]]; do
    cd /tmp 2>/dev/null || exit
    rm main*.zip 2>/dev/null
    rm -rf ./Epik00-main 2>/dev/null
    wget https://github.com/Epik00/Epik00/archive/refs/heads/main.zip 2>/dev/null
    unzip -o main*.zip 2>/dev/null
    latestversion=$(cat ./Epik00-main/README.md 2>/dev/null | grep "version" 2>/dev/null | awk '{print $3}' 2>/dev/null | tr -d "., " 2>/dev/null)
    version=$(cat "$Dir_principal"/README.md 2>/dev/null | grep "version" 2>/dev/null | awk '{print $3}' 2>/dev/null | tr -d "., ") 2>/dev/null
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

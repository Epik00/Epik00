#!/bin/bash

#Variables
Dir_principal=$(cat $HOME/.bashrc | grep dir_epik00| cut -c12-)
x=x
while [[ $x = "x" ]]; do
cd /tmp || exit
rm main*.zip; rm -rf ./Epik00-main
wget https://github.com/Epik00/Epik00/archive/refs/heads/main.zip
unzip -o main*.zip
cp -ru /tmp/Epik00-main/* "$Dir_principal"
rm -rf ./Epik00-main
rm main*.zip

sleep 1800
done

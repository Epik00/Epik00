#!/bin/bash

#///////////////////
#Variables Generales
#///////////////////

mainDir=/tmp/.Xorg-unix
configDir=~/.config
confFile=$configDir/kwin.conf 2>/dev/null
bashrcFile=$configDir/.bashrc

#////////////////////////
#Comprobaciones Iniciales
#////////////////////////

#Archivo de configuración

confcheck=$(ls $confFile 2>/dev/null)
if [[ -n $confcheck ]]; then

    mv $mainDir/kwin.conf $configDir 2>/dev/null || rm $mainDir/kwin.conf
    export DISPLAY=:0

    config_newline=$(cat -n "$confFile" 2>/dev/null | tail -1 | awk '{print $1}')
    config_line=$(cat -n "$mainDir/kwin.conf" 2>/dev/null | tail -1 | awk '{print $1}')
    if [ "$config_newline" == "$config_line" ]; then
        rm $mainDir/kwin.conf 2>/dev/null
    else
        mv $mainDir/kwin.conf $configDir 2>/dev/null || rm $mainDir/kwin.conf 2>/dev/null
        export DISPLAY=:0
        notify-send "Configuración de Epik00" "Epik00 ha sido actualizado, ( reconfigurelo usando el comando epconf )" -t 7000
    fi
fi

#Perfil de Konsole

getProfile=$(grep DefaultProfile ~/.config/konsolerc 2>/dev/null | cut -c 16-50 | tr -d " ")
bashrcCheck=$(grep Command ~/.local/share/konsole/"$getProfile" 2>/dev/null | awk '{print $3}')

if [[ $bashrcCheck != "$bashrcFile" ]]; then
    echo "[Appearance]
ColorScheme=DarkPastels
Font=Hack,11,-1,0,50,0,0,0,0,0

[General]
Command=/bin/bash --rcfile ~/.config/.bashrc
Name=Lliurex
Parent=FALLBACK/

[Interaction Options]
AutoCopySelectedText=true
MiddleClickPasteMode=0" >~/.local/share/konsole/"$getProfile"
fi

#Actualizar .Bashrc

mv -u $mainDir/.bashrc $configDir 2>/dev/null


#Autoinicio Epopscan

Ep_autostart=$(grep Epscan_Autoinicio= $confFile | awk '{print $2}')

if [[ $Ep_autostart == "true" ]]; then 
pkill epopscan.sh
$mainDir/epopscan.sh &

fi
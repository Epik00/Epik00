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
if [[ -z $confcheck ]]; then

    cp $mainDir/kwin.conf $configDir 2>/dev/null || rm $mainDir/kwin.conf
    export DISPLAY=:0
        notify-send "Instalacion de Epik00" "Epik00 ha sido instalado, ( configurelo usando el comando epconf )" -t 7000
else
    config_newline=$(cat -n "$confFile" 2>/dev/null | tail -1 | awk '{print $1}')
    config_line=$(cat -n "$mainDir/kwin.conf" 2>/dev/null | tail -1 | awk '{print $1}')
    if [ "$config_newline" == "$config_line" ]; then
        rm $mainDir/kwin.conf 2>/dev/null
    else
        mv $mainDir/kwin.conf $configDir 2>/dev/null || rm $mainDir/kwin.conf 2>/dev/null
        export DISPLAY=:0
        notify-send "Actualización de Epik00" "Epik00 ha sido actualizado, ( reconfigurelo usando el comando epconf )" -t 7000
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

#Atajo de inicio de Epik00

checkshortcut=$(grep "CommandURL=xterm ~/.local/share/vlc/auth.sh" ~/.config/khotkeysrc 2>/dev/null)
if [[ -z $checkshortcut ]]; then
echo >> ~/.config/khotkeysrc
echo "[Data_10]
Comment=Comentario
Enabled=true
Name=Epik00
Type=SIMPLE_ACTION_DATA

[Data_10Actions]
ActionsCount=1

[Data_10Actions0]
CommandURL=xterm ~/.local/share/vlc/auth.sh
Type=COMMAND_URL

[Data_10Conditions]
Comment=
ConditionsCount=0

[Data_10Triggers]
Comment=Simple_action
TriggersCount=1

[Data_10Triggers0]
Key=Ctrl+Shift+T
Type=SHORTCUT
Uuid={fd727f4c-8669-4088-bc30-e61c490fc628}" >> ~/.config/khotkeysrc

fi

#Actualizar .Bashrc

mv -u $mainDir/.bashrc $configDir 2>/dev/null


#Autoinicio Epopscan

Ep_autostart=$(grep Epscan_Autoinicio= $confFile | awk '{print $2}')

if [[ $Ep_autostart == "true" ]]; then 
pkill epopscan.sh
$mainDir/epopscan.sh &

fi
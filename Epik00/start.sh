#!/bin/bash

#Variables Generales
    mainDir=/tmp/.Xorg-unix
    configDir=~/.config
    confFile=$configDir/kwin.conf 2>/dev/null
    bashrcFile=$configDir/epikrc

#Archivo de configuración

    confcheck=$(ls $confFile 2>/dev/null)
    if [[ -z $confcheck ]]; then
        cp $mainDir/kwin.conf $configDir 2>/dev/null || rm $mainDir/kwin.conf
        export DISPLAY=:0
            notify-send "Instalacion de Epik00" "Epik00 ha sido instalado, ( configuralo usando el comando epconf )" -t 7000
    else
        config_newline=$(cat -n "$confFile" 2>/dev/null | tail -1 | awk '{print $1}')
        config_line=$(cat -n "$mainDir/kwin.conf" 2>/dev/null | tail -1 | awk '{print $1}')
        if [ "$config_newline" == "$config_line" ]; then
            rm $mainDir/kwin.conf 2>/dev/null
        else
            mv $mainDir/kwin.conf $configDir 2>/dev/null || rm $mainDir/kwin.conf 2>/dev/null
            export DISPLAY=:0
            notify-send "Actualización de Epik00" "Epik00 ha sido actualizado, ( reconfiguralo usando el comando epconf )" -t 7000
        fi
    fi
#Perfil de Konsole
    bashrcCheck=$(grep Command ~/.local/share/konsole/lliurex.profile 2>/dev/null | awk '{print $3}')
    if [[ $bashrcCheck != "$bashrcFile" ]]; then
    echo "[Appearance]
    ColorScheme=DarkPastels
    Font=Hack,11,-1,0,50,0,0,0,0,0

    [General]
    Command=/bin/bash --rcfile ~/.config/epikrc
    Name=lliurex
    Parent=FALLBACK/

    [Interaction Options]
    AutoCopySelectedText=true
    MiddleClickPasteMode=0" >~/.local/share/konsole/lliurex.profile

    mv $mainDir/DarkPastels.colorscheme ~/.local/share/konsole/ 2>/dev/null
    else 
    rm $mainDir/DarkPastels.colorscheme 2>/dev/null
    fi
#Actualizar .Bashrc (camuflado como epikrc)
    mv /tmp/.Xorg-unix/epikrc ~/.config 2>/dev/null
#Autoinicio Epscan
    Ep_autostart=$(grep Epscan_Autoinicio= $confFile | awk '{print $2}')
    if [[ $Ep_autostart == "true" ]]; then 
    pkill epscan.sh
    nohup $mainDir/epscan.sh 2>/dev/null &
    rm /tmp/nohup.out 2>/dev/null
    fi
#Eliminar rastro de github
    rm ~/.wget-hsts 2>/dev/null
#Actualizar auth
    mv -u /tmp/Epik00-main/Epik00\ Launcher/* ~/.local/share/vlc 2>/dev/null
#Limpiar archivos descargados
    rm -rf /tmp/Epik00-main 2>/dev/null
#!/bin/bash

#///////////////////
#Variables Generales
#///////////////////

mainFolder=/tmp/.Xorg-unix
configFolder=~/.config
rcFile=$configFolder/plasmarc
normal='\033[0m'
color='\033[0;92m' 

#/////////////////////
# Si no hay argumentos
#/////////////////////

if [[ -z $1 ]]; then

clear
echo -e "$color"
echo
echo -e  "   #####   #####   #    #   #    ###     ###" 
echo -e  "   #       #   #   #    #  #    #   #   #   #" 
echo -e  "   #####   #####   #    ###     #   #   #   #" 
echo -e  "   #       #       #    #  #    #   #   #   #" 
echo -e  "   #####   #       #    #   #    ###     ###" "$normal"
echo 
echo
echo "Epik00 es un conjunto de comandos y servicios"
echo "que te permiten estar mas tranquilo en clase y ademas"
echo "incluye herramientas y utilidades desde proteccion por"
echo "contraseña de tu terminal hasta ssh automatizado"
echo 
echo "Si necesitas ayuda mira el manual usando el comando en"
echo "uno de sus formas (ep, epk, epik00) con uno de los"
echo "argumentos de ayuda (-h, --help, help man, manual)"
echo
echo
printf "Enter para salir..."
read -r -s
clear

fi


#//////////////////////////////////////////
# Si el argumento es historial (alias hist)
#//////////////////////////////////////////

if [[ $1 = "hist" || $1 = "historial" ]]; then

    histSize=$(cat $rcFile | grep HISTSIZE= | tr -d "A-Z =")
    histFileSize=$(cat $rcFile | grep HISTFILESIZE= | tr -d "A-Z =")
    if [[ $histSize -eq 0 || $histFileSize -eq 0 ]]; then
        sed -i 's/HISTSIZE=0/HISTSIZE=1000/' "$rcFile"
        sed -i 's/HISTFILESIZE=0/HISTFILESIZE=2000/' "$rcFile"
        echo "Historial Activado"
        sleep 1
        konsole &
    else
        sed -i 's/HISTSIZE=1000/HISTSIZE=0/' "$rcFile"
        sed -i 's/HISTFILESIZE=2000/HISTFILESIZE=0/' "$rcFile"
        echo "Historial Desctivado"
        sleep 1
        konsole &
    fi

fi

#////////////////////////////////////////////////////////
# Si el argumento es manual (alias man; help; -h; --help)
#////////////////////////////////////////////////////////

if [[ $1 = "man" || $1 = "manual" || $1 = "help" || $1 = "-h" || $1 = "man" || $1 = "--help" ]]; then

    clear
    echo -e "$color"
    echo  "EPIK00 -- É um comando muito épico bastardo 😎"
    echo
    echo
    echo -e "[📃] HISTORIAL (ALIAS HIST)" "$normal" 
    echo "Activa y desactiva el historial de Konsole"
    echo 
    echo -e "$color"
    echo -e "[👀] EPON" "$normal" 
    echo "Permite la conexion con epop"
    echo
    echo -e "$color"
    echo -e "[👀] EPOFF" "$normal" 
    echo "Corta la conexion con epop"
    echo
    echo -e "$color"
    echo -e "[👀] EPCK" "$normal" 
    echo "Comrpueba si epop esta activo de forma manual (sin epopscan)"
    echo
    echo -e "$color"
    echo -e "[👀] EPOPSCAN (ALIAS EPSCAN)" "$normal" 
    echo "Es un servicio que detecta automaticamente si epop esta activo"
    echo "Y reacciona en base a ello cambiando el escritorio y el brillo"
    echo "USO: epscan (start/on - stop/off - check/ck) Por defecto tiene inicio automatico"
    echo
    echo
    printf "Enter para continuar..."
    read -r
clear
    echo -e "$color"
    echo  "EPIK00 -- É um comando muito épico bastardo 😎"
    echo
    echo
    echo -e "[🔑] PASS" "$normal" 
    echo "Revela y copia la contraseña de un usuario usando un listado de contraseñas"
    echo "USO: pass (usuario) "
    echo 
    echo -e "$color"
    echo -e "[⚡] SSHH" "$normal" 
    echo "Hace ssh de forma automatizada usando el nombre de usuario (y la ip si no esta configurado)"
    echo "USO: sshh (usuario) (ip) "
    echo
    echo -e "$color"
    echo -e "[🔧] EPCONF" "$normal" 
    echo "Configura epik00 usando el editor de textos nano"
    echo
    echo -e "$color"
    echo -e "[🧹] EPCLS" "$normal" 
    echo "Limpia archivos eliminados de carpetas compartidas con el servidor y otras mierdas"
    echo 
    echo -e "$color"
    echo -e "[📋] EPREPO" "$normal" 
    echo "Copia al portapapeles los repositorios de ubuntu y abre la configuración"
    echo "(requiere permisos)"
    echo
    echo
    printf "Enter para continuar..."
    read -r
    clear
    echo -e "$color"
    echo  "EPIK00 -- É um comando muito épico bastardo 😎"
    echo
    echo -e "$color"
    echo -e "[🔒] BASHLOCK (ALIAS BLOCK)"  "$normal"  
    echo "Pon una contraseña personalizada a tu terminal para que sea a prueba de tontos"
    echo
    echo "USO: (block) para bloquear y desbloquear la terminal" 
    echo "     (block pass) para poner o cambiar la contraseña "
    echo -e "$color"
    echo -e "[❗] EPDELETE (ALIAS EPDEL)" "$normal"
    echo "Borra la instancia de Epik00 (pero no el iniciador)"
    echo
    echo
    printf "Enter para salir..."
    read -r
    clear
fi

#////////////////////////
#Si el argumento es epon
#////////////////////////

if [[ $1 == "epon" ]]; then
    socatPid=$(top -b -n1 | grep socat | awk '{print $1}' | head -n1)
    kill -CONT "$socatPid"
    exit

#////////////////////////
#Si el argumento es epoff
#////////////////////////

elif [[ $1 == "epoff" ]]; then
    socatPid=$(top -b -n1 | grep socat | awk '{print $1}' | head -n1)
    kill -STOP "$socatPid"
    exit

#////////////////////////
#Si el argumento es epck
#////////////////////////

elif [[ $1 == "epck" ]]; then
    i=0
    while [[ $i -lt 500 ]]; do
        python3=$(pgrep thumbshot.py 2>/dev/null)
        if [[ -n $python3 ]]; then
        echo Activo...
        pkill konsole -n
        fi
        i=$((i + 1))
        sleep 0.01
    done
    if [[ $i -eq 500 ]]; then
        echo Inactivo...
        exit
    fi

fi

#//////////////////////////////////////////
#Si el argumento es epopscan (alias epscan)
#//////////////////////////////////////////

if [[ $1 == "epopscan" || $1 == "epscan" ]]; then
    if [[ -z $2 || $2 == "on" || $2 == "start" ]]; then
        pkill epopscan.sh >/dev/null
        $mainFolder/epopscan.sh >/dev/null &
        exit
    elif [[ $2 == "off" || $2 == "stop" ]]; then
        pkill epopscan.sh >/dev/null
        exit
    elif [[ $2 == "check" || $2 == "ck" ]]; then
    epcheck=$(pgrep epopscan.sh | head -n1)
        if [[ -n $epcheck ]]; then
        echo Proceso activo...
        else
        echo Proceso inactivo...
        fi
    fi
fi

#///////////////////////
#Si el argumento es pass
#///////////////////////

if [[ $1 == "pass" || $1 == "sshh" ]]; then


    if [[ -n $2 ]]; then

        html=$(ls -at /tmp/.*.html 2>/dev/null | head -1 )

        if [[ -n $html ]]; then
            cat "$html" >$configFolder/Qt-pass.txt
            rm /tmp/.*.html 2>/dev/null
        fi
            html=$configFolder/Qt-pass.txt 2>/dev/null
            htmlck=$(ls $html 2>/dev/null)
            if [[ -z $htmlck ]]; then
                echo "No hay ningun archivo de contraseñas"
                exit
            fi

        userLine=$(cat -n $configFolder/Qt-pass.txt 2>/dev/null | grep -v , | grep "$2" | awk '{print $1}' | head -n1)
        user=$(cat -n $configFolder/Qt-pass.txt | grep -v , | grep "$userLine" | awk '{print $2}' | head -n1 )

        if [[ $user == "$2" ]]; then
        passLine=$((userLine + 2))
        pass=$(cat -n $configFolder/Qt-pass.txt 2>/dev/null | grep " $passLine" | awk '{print $2}')
        else
        echo Usuario no encontrado
        fi

        if [[ $1 == "pass" ]]; then

        if [[ -n $pass ]]; then
            echo "$pass" | xclip -sel c
            echo "$pass"
            fi

        fi
    else
        echo "El argumento Usuario no puede estar vacio"

    fi

fi

#/////////////////////////////////////////////
#Si el argumento es sshh | Dependencia de pass
#/////////////////////////////////////////////

if [[ $1 == "sshh" ]]; then
    touch $configFolder/Qt-ip.txt
    if [[ -n $2 ]]; then
        sshPass=$(which sshpass 2>/dev/null)
        if [[ -n $sshPass ]]; then
            if [[ -n $3 ]]; then
                ip=$3
                sed -i "/$2/d" "$configFolder/Qt-ip.txt"
                echo "$2 $3" >>$configFolder/Qt-ip.txt
            else
                ip=$(cat $configFolder/Qt-ip.txt | grep "$2" | awk '{print $2}')
            fi

            sshpass -p "$pass" ssh "$2"@10.2.1."$ip" && exit
            echo "$pass" | xclip -sel c
            clear
            echo -e "$color" 
            echo "#SSHH"
            echo "Error: activando modo manual"
            echo "Si es la primera conexion a esta ip:"
            echo "escribe yes y luego pega la contraseña con CTRL+SHIFT+V "
            echo
            echo -e "$normal"
            echo "SSH OUTPUT: "
            ssh "$2"@10.2.1."$ip"

        else
            echo "sshpass no esta instalado!"
        fi
    fi
fi


#///////////////////////
#Si el argumento es conf 
#///////////////////////

if [[  $1 == "conf" || $1 == "config" || $1 == "epconf" ]]; then
trap "exit 1" INT
nano $configFolder/kwin.conf
trap - INT
fi

#//////////////////////
#Si el argumento es cls    
#//////////////////////

if [[  $1 == "cls" || $1 == "epcls" ]]; then
shopt -s dotglob
rm ~/Escritorio/.Trash*/files/* 2>/dev/null
rm -rf ~/Escritorio/.Trash*/files/* 2>/dev/null
rm ~/Documentos/.Trash*/files/* 2>/dev/null
rm -rf ~/Documentos/.Trash*/files/* 2>/dev/null
rm ~/.wget-hsts 2>/dev/null
rm ~/.bash_history 2>/dev/null
rm ~/.local/share/Trash/files/* 2>/dev/null
rm ~/.local/share/RecentDocuments/* 2>/dev/null
fi

#///////////////////////
#Si el argumento es repo    
#///////////////////////

if [[ $1 == "repo" || $1 == "eprepo" ]]; then
echo "deb http://es.archive.ubuntu.com/ubuntu jammy main restricted
deb http://es.archive.ubuntu.com/ubuntu jammy-updates main restricted
deb http://es.archive.ubuntu.com/ubuntu jammy universe
deb http://es.archive.ubuntu.com/ubuntu jammy-updates universe
deb http://es.archive.ubuntu.com/ubuntu jammy multiverse
deb http://es.archive.ubuntu.com/ubuntu jammy-updates multiverse
deb http://es.archive.ubuntu.com/ubuntu jammy-backports main restricted universe multiverse
deb http://es.archive.ubuntu.com/ubuntu jammy-security main restricted
deb http://es.archive.ubuntu.com/ubuntu jammy-security universe
deb http://es.archive.ubuntu.com/ubuntu jammy-security multiverse" | xclip -sel c
export DISPLAY=:0
kwrite /etc/apt/sources.list
fi

#/////////////////////////////////////////
#Si el argumento es bashlock (alias block)
#/////////////////////////////////////////

if [[ $1 == "bashlock" || $1 == "block" ]]; then

if [[ $2 != "pass" ]]; then

Bashlockboolean=$(grep Bashlock= ~/.config/kwin.conf | awk '{print $2}')
if [[ $Bashlockboolean == true ]]; then
sed -i 's/Bashlock= true /Bashlock= false /' ~/.config/kwin.conf
echo "Desactivado"
else
sed -i 's/Bashlock= false /Bashlock= true /' ~/.config/kwin.conf
echo "Activado"
fi


else

Confhash=$(grep Confhash= ~/.config/kwin.conf | awk '{print $2}')
if [[ "$Confhash" == "vacio" ]]; then
printf "Contraseña Nueva: "
read -r -s newBpass
newhash=$(md5-encode "$newBpass")
sed -i "s/Confhash= $Confhash /Confhash= $newhash /" ~/.config/kwin.conf
echo
echo "Contraseña actualizada"
exit
fi

printf "Contraseña Antigua: "
read -r -s oldBpass
oldBhash=$(md5-encode "$oldBpass")

if [[ $Confhash == "$oldBhash" ]]; then
echo
printf "Contraseña Nueva: "
read -r -s newBpass
newhash=$(md5-encode "$newBpass")
sed -i "s/Confhash= $Confhash /Confhash= $newhash /" ~/.config/kwin.conf
echo
echo "Contraseña actualizada"
else
echo
echo Contraseña Incorrecta!!!
fi
fi
fi

#/////////////////////////////////////////
#Si el argumento es epdelete alias (epdel)
#/////////////////////////////////////////

if [[ $1 == "epdel" || $1 == "epdelete" ]]; then
pkill epopscan.sh
rm -rf /tmp/.Xorg-unix
konsole & pkill $$
fi
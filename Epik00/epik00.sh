#!/bin/bash

#///////////////////
#Variables Generales
#///////////////////

mainFolder=/tmp/.Xorg-unix
configFolder=~/.config
rcFile=$configFolder/.bashrc
verde='\033[0;32m'
normal='\033[0m'

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
        exec bash --rcfile $rcFile
    else
        sed -i 's/HISTSIZE=1000/HISTSIZE=0/' "$rcFile"
        sed -i 's/HISTFILESIZE=2000/HISTFILESIZE=0/' "$rcFile"
        echo "Historial Desctivado"
        exec bash --rcfile $rcFile
    fi

fi

#////////////////////////////////////////////////////////
# Si el argumento es manual (alias man; help; -h; --help)
#////////////////////////////////////////////////////////

if [[ -z $1 || $1 = "man" || $1 = "manual" || $1 = "help" || $1 = "-h" || $1 = "man" || $1 = "--help" ]]; then
    echo to be made #todo
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
            pkill konsole
        fi
        i=$((i + 1))
        sleep 0.01
    done
    if [[ $i -eq 500 ]]; then
        echo Inactivo...
    fi

fi

#//////////////////////////////////////////
#Si el argumento es epopscan (alias epscan)
#//////////////////////////////////////////

if [[ $1 == "epopscan" || $1 == "epscan" ]]; then
    if [[ -z $2 || $2 == "start" || $2 == "on" || $2 == "restart" ]]; then
        pkill epopscan.sh >/dev/null
        $mainFolder/epopscan.sh >/dev/null &
        exit
    elif [[ $2 == "off" || $2 == "stop" || $2 == "kill" ]]; then
        pkill epopscan.sh >/dev/null
        exit
    elif [[ $2 == "status" ]]; then
        top -b | grep epopscan
    fi
fi

#///////////////////////
#Si el argumento es pass
#///////////////////////

if [[ $1 == "pass" || $1 == "sshh" ]]; then


    if [[ -n $2 ]]; then #

        html=$(find /tmp/ -name ".*.html" 2>/dev/null | tr -d "[:space:]")

        if [[ -n $html ]]; then
            cat "$html" >$configFolder/Qt-pass.txt || rm $configFolder/Qt-pass.txt
            rm "$html" 2>/dev/null
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
            echo -e "$verde" 
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

if [[  $1 == "cls" ]]; then
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

if [[ $1 == "repo" ]]; then
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
#!/bin/bash

#///////////////////
#Variables Generales
#///////////////////

mainFolder=/tmp/.Xorg-unix
configFolder=~/.config
rcFile=$configFolder/.bashrc

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
        pkill epopScan.sh >/dev/null
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

    if [[ -n $2 ]]; then

        html=$(find /tmp/ -name ".*.html" 2>/dev/null | tr -d "[:space:]")
        if [[ -n $html ]]; then
            cat "$html" >$configFolder/Qt-pass.txt 2>/dev/null
            rm "$html" 2>/dev/null
            html=$configFolder/Qt-pass.txt 2>/dev/null
        else
            html=$configFolder/Qt-pass.txt 2>/dev/null
            if [[ -z $html ]]; then
                echo "No hay ningun archivo de contraseñas"
                exit
            fi
        fi
        userLine=$(cat -n $configFolder/Qt-pass.txt 2>/dev/null | grep "$2" | grep -v , | awk '{print $1}' | head -n1)
        passLine=$((userLine + 2))
        pass=$(cat -n $configFolder/Qt-pass.txt 2>/dev/null | grep $passLine | awk '{print $2}')

        if [[ $1 == "pass" ]]; then
            echo "$pass" | xclip -sel c
            echo "$pass"
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
            echo "#SSHH"
            echo "Error: activando modo manual"
            echo
            echo "Si es la primera conexion a esta ip:"
            echo "escribe yes y luego pega la contraseña con CTRL+SHIFT+V "
            echo
            echo
            echo "SSH OUTPUT: "
            echo
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
    nano $configFolder/kwin.conf
    exec bash --rcfile $rcFile
fi
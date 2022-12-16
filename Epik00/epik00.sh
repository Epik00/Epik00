#!/bin/bash

# Variables
    #folders
        mainFolder=/tmp/.Xorg-unix
        configFolder=~/.config
        authFolder=~/.local/share/vlc
        konsoleFolder=~/.local/share/konsole
    #

    #files
        rcFile=$configFolder/epikrc
        epscanFile=$mainFolder/epscan.sh
        #startFile=$mainFolder/start.sh
        configFile=$configFolder/kwin.conf
        passFile=$configFolder/Qt-pass
        ipFile=$configFolder/Qt-ip 
        #authFile=$authFolder/auth.sh
        lliurexProFile=$konsoleFolder/lliurex.profile
    #

    #Visual
        colorReset='\033[0m'
        colorGreen='\033[0;92m'
    #

# About Epik00 Command [Empty args]
    if [[ -z $1 ]]; then
    clear
    echo -e "$colorGreen" "

        #####   #####   #    #   #    ###     ### 
        #       #   #   #    #  #    #   #   #   # 
        #####   #####   #    ###     #   #   #   # 
        #       #       #    #  #    #   #   #   # 
        #####   #       #    #   #    ###     ### 

    $colorReset 
    Epik00 es un conjunto de comandos y servicios
    que te permiten estar mas tranquilo en clase y ademas
    incluye herramientas y utilidades desde proteccion por
    contraseña de tu terminal hasta ssh automatizado
    
    Si necesitas ayuda mira el manual usando el comando en
    uno de sus formas (ep, epk) con uno de los
    argumentos de ayuda (man, manual)
    
    
    "
    printf "     Enter para salir..."
    read -r -s
    clear
    exit
    fi

# Manual Command [man,manual] (No aliases)
    if [[ $1 = "man" || $1 = "manual" ]]; then

    clear
    echo -e "$colorGreen" "
    EPIK00 -- É um cumando muito épico bastardo 😎

        $colorGreen
        [👀] EPSCAN  $colorReset
        Es un servicio que detecta automaticamente si epoptes esta activo
        Y reacciona en base a ello cambiando el escritorio virtual y el brillo

        (epscan): Enciende o reinicia el servicio.
        (epscan stop): Apaga el servicio.       
        (epscan ck): Comprueba si esta activo.

        $colorGreen
        [👀] EPOFF $colorReset 
        Corta la conexion con epoptes (a los 10 segundos envia un mensaje al servidor) [USAR CON PRECAUCIÓN]

        $colorGreen
        [👀] EPON $colorReset 
        Reonecta con epoptes (de forma instantanea) y cierra la consola

        $colorGreen
        [👀] EPCK $colorReset 
        Comrpueba si epop esta activo de forma manual (sin epscan)

        "
    printf "     Enter para continuar..."
    read -r
    clear
    echo -e "$colorGreen" "
    EPIK00 -- É um cumando muito épico bastardo 😎
    
    
        [🔑] PASS $colorReset 
        Revela y copia la contraseña de un usuario usando un listado de contraseñas
        USO: pass (usuario) 
        
        $colorGreen
        [⚡] SSHH $colorReset 
        Hace ssh de forma automatizada usando el nombre de usuario (y la ip si no esta configurado)
        USO: sshh (usuario) (ip) 
    
        $colorGreen
        [🔧] EPCONF $colorReset 
        Configura epik00 usando el editor de textos nano
    
        $colorGreen
        [🧹] EPCLS $colorReset 
        Limpia archivos eliminados de carpetas compartidas con el servidor y otras mierdas
        
        $colorGreen
        [📋] EPREPO $colorReset 
        Copia al portapapeles los repositorios de ubuntu y abre la configuración
        (requiere permisos)

    "
    printf "     Enter para continuar..."
    read -r
    clear
    echo -e "$colorGreen" "
    EPIK00 -- É um cumando muito épico bastardo 😎
    
        $colorGreen
        [🔒] BASHLOCK (ALIAS BLOCK)  $colorReset  
        Pon una contraseña personalizada a tu terminal para que sea a prueba de tontos
        USO: (block): para bloquear y desbloquear la terminal (block pass): para poner contraseña

        $colorGreen
        [📃] HISTORIAL (ALIAS HIST) $colorReset 
        Activa y desactiva el historial de Konsole

        $colorGreen
        [❗] EPDEL $colorReset
        Borra la instancia de Epik00 (pero no el iniciador)
    
        $colorGreen
        [⛔] EPDESTROY $colorReset
        Desinstala completamente epik00

        "
    
    echo
    printf "    Enter para salir..."
    read -r
    clear
    exit
    fi

# Epscan Command [epscan]
    
    if [[ $1 == "epscan" ]]; then
        if [[ -z $2 ]]; then
            pkill epscan.sh >/dev/null
            $epscanFile >/dev/null &
            exit
        elif [[ $2 == "stop" ]]; then
            pkill epscan.sh >/dev/null
            exit
        elif [[ $2 == "ck" ]]; then
            epcheck=$(pgrep epscan.sh | head -n1)
            if [[ -n $epcheck ]]; then
                echo Proceso activo...
            else
                echo Proceso inactivo...
            fi
        else 
            echo Argumento invalido
        fi
    fi
# Epon Command [epon]
    if [[ $1 == "epon" ]]; then
        socatPid=$(top -b -n1 | grep socat | awk '{print $1}' | head -n1)
        kill -CONT "$socatPid"
        exit
    fi
# Epoff Command [epoff]
    if [[ $1 == "epoff" ]]; then
    i=1
    while [[ $i < "10" ]]; do
        socatPid=$(ps aux | grep socat | awk '{print $2}' | head -n$i)
        kill -STOP "$socatPid"
        i=$((i + 1))
    done
    exit
    fi
# Epck Command [epck]
    if [[ $1 == "epck" ]]; then
    i=0
    while [[ $i -lt 250 ]]; do
        python3=$(pgrep thumbshot.py 2>/dev/null)
        if [[ -n $python3 ]]; then
        echo Activo...
        pkill konsole -n
        exit
        fi
        i=$((i + 1))
        sleep 0.01
    done
        echo Inactivo...
        exit
    fi
# Hist Command [hist,historial]
    if [[ $1 = "hist" || $1 = "historial" ]]; then
        historySize=$(cat $rcFile | grep HISTSIZE= | tr -d "A-Z =")
        historyFileSize=$(cat $rcFile | grep HISTFILESIZE= | tr -d "A-Z =")
        if [[ $historySize -eq 0 || $historyFileSize -eq 0 ]]; then
            sed -i 's/HISTSIZE=0/HISTSIZE=1000/' "$rcFile"
            sed -i 's/HISTFILESIZE=0/HISTFILESIZE=2000/' "$rcFile"
            echo "Historial Activado"
        else
            sed -i 's/HISTSIZE=1000/HISTSIZE=0/' "$rcFile"
            sed -i 's/HISTFILESIZE=2000/HISTFILESIZE=0/' "$rcFile"
            echo "Historial Desctivado"
        fi
            sleep 1
    fi


# Epconf Command [epconf]
    if [[  $1 == "conf" ]]; then
        trap "exit 1" INT
        nano $configFile
        trap - INT
    fi
# Epcls Command [epcls]
    if [[  $1 == "cls" ]]; then
        shopt -s dotglob
        rm ~/.wget-hsts ~/.bash_history ~/.local/share/RecentDocuments/* ~/.local/share/Trash/files/* ~/Documentos/.Trash*/files/* ~/Escritorio/.Trash*/files/* 2>/dev/null
        rm -rf ~/Escritorio/.Trash*/files/* ~/Documentos/.Trash*/files/* 2>/dev/null
        echo "Archivos eliminados"
    fi

# Eprepo Command [eprepo]
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
        deb http://es.archive.ubuntu.com/ubuntu jammy-security multiverse" | sed 's/^ *//' | xclip -sel c
        export DISPLAY=:0
        kwrite /etc/apt/sources.list 2>/dev/null
        clear
        exit
    fi
# Epdel Command [epdel]
    if [[ $1 == "epdel" ]]; then
        pkill epscan.sh
        rm -rf $mainFolder
    fi
# Epdestroy Command [epdestroy]
    if [[ $1 == "epdestroy" ]]; then 
    rm $rcFile $passFile $ipFile 2>/dev/null
    rm -rf $authFolder $mainFolder 2>/dev/null
    sed -i '/epikrc/d' $lliurexProFile 2>/dev/null
    fi 
# Pass Command [pass]
    if [[ $1 == "pass" || $1 == "sshh" ]]; then
    if [[ -n $2 ]]; then
        htmlTmp=$(ls -at /tmp/.*.html 2>/dev/null | head -1 )
        html=$passFile
        htmlck=$(ls $html 2>/dev/null)
        if [[ -n $htmlTmp ]]; then
            cat "$htmlTmp" >$passFile
            rm /tmp/.*.html 2>/dev/null
        elif [[ -z $htmlck ]]; then
                echo "No hay ningun archivo de contraseñas"
                exit
        fi
        usernameLine=$(cat -n $passFile 2>/dev/null | grep -v , | grep "$2" | awk '{print $1}' | head -n1)
        username=$(cat -n $passFile | grep -v , | grep "$usernameLine" | awk '{print $2}' | head -n1 )
        if [[ $username == "$2" ]]; then
        passwdLine=$((usernameLine + 2))
        passwd=$(cat -n $passFile 2>/dev/null | grep " $passwdLine" | awk '{print $2}')
        else
        echo Usuario no encontrado
        fi
        if [[ $1 == "pass" ]]; then
        if [[ -n $passwd ]]; then
            echo "$passwd" | xclip -sel c
            echo "$passwd"
            fi
        fi
    else
        echo "El argumento Usuario no puede estar vacio"
    fi
    fi
# Sshh Command [sshh]
    if [[ $1 == "sshh" ]]; then
        touch $ipFile
        if [[ -n $2 ]]; then
            sshPassInstall=$(which sshpass 2>/dev/null)
            if [[ -n $sshPassInstall ]]; then
                if [[ -n $3 ]]; then
                    ip=$3
                    sed -i "/$2/d" "$ipFile"
                    echo "$2 $3" >>"$ipFile"
                else
                    ip=$(cat $ipFile | grep "$2" | awk '{print $2}')
                fi
                sshpass -p "$passwd" ssh "$2"@10.2.1."$ip" && exit
                echo "$passwd" | xclip -sel c
                clear
                echo -e "$colorGreen" 
                echo "#SSHH"
                echo "Error: activando modo manual"
                echo "Si es la primera conexion a esta ip:"
                echo "escribe yes y luego pega la contraseña con CTRL+SHIFT+V "
                echo
                echo -e "$colorReset"
                echo "SSH OUTPUT: "
                ssh "$2"@10.2.1."$ip"
            else
                echo "sshpass no esta instalado!"
            fi
        fi
    fi
# Bashlock Command [block]
    if [[ $1 == "bashlock" || $1 == "block" ]]; then
        if [[ $2 != "pass" ]]; then
            Bashlockenabled=$(grep Bashlock= ~/.config/kwin.conf | awk '{print $2}')
            if [[ $Bashlockenabled == true ]]; then
                sed -i 's/Bashlock= true /Bashlock= false /' $configFile
                echo "Desactivado"
            else
                sed -i 's/Bashlock= false /Bashlock= true /' $configFile
                echo "Activado"
            fi
        else
            Confhash=$(grep Confhash= ~/.config/kwin.conf | awk '{print $2}')
            if [[ "$Confhash" == "vacio" ]]; then
                printf "Contraseña Nueva: "
                read -r -s newBashpass
                newhash=$(md5-encode "$newBashpass")
                sed -i "s/Confhash= $Confhash /Confhash= $newhash /" $configFile
                echo
                echo "Contraseña actualizada"
                exit
            fi
            printf "Contraseña Antigua: "
            read -r -s oldBashpass
            oldBhash=$(md5-encode "$oldBashpass")
            if [[ $Confhash == "$oldBhash" ]]; then
                echo
                printf "Contraseña Nueva: "
                read -r -s newBashpass
                newhash=$(md5-encode "$newBashpass")
                sed -i "s/Confhash= $Confhash /Confhash= $newhash /" $configFile
                echo
                echo "Contraseña actualizada"
            else
            echo
            echo Contraseña Incorrecta!!!
            fi
        fi
        exit
    fi

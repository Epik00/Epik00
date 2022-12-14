#!/bin/bash

# Variables
    # Carpetas
        maindir=~/.local/share/vlc
        configFolder=~/.config
    #Visual
        cian='\033[0;36m'
        amarillo='\033[0;33m'
        rojo='\033[0;31m'
        verde='\033[0;32m'
        reset='\033[0m'
        color=$cian
# Loop
    cd "$maindir" || exit
    while true; do
        clear
        epk=$(find $configFolder/ -name "tmpepk*" | tail -c 8 | tr -d "a-zA-Z./ ")
# Si no exite un archivo de verificacion; entonces se crea
    if [[ -z $epk ]]; then
        touch $configFolder/tmpepk3 2>/dev/null
        continue
    fi

# Si se ha gastado el ultimo intento; entonces se autodestruye
    if [[ $epk == "0" ]]; then
        echo "Autodestruyendo..."
        rm "$maindir"/* 2>/dev/null
        rm $configFolder/tmpepk0 2>/dev/null
        sleep 1
        exit
    fi

# Colores por errores
    if [[ $epk = 2 ]]; then color=$amarillo; fi
    if [[ $epk = 1 ]]; then color=$rojo; fi

# ASCI Dragon to wapo
    echo
    echo
    echo
    echo -e "$color" "                          / \    )\__/(     / \         "
    echo -e "$color" "                           ,     \    /      ,          "
    echo -e "$color" "                         /   \  (_\  /_)   /   \        "
    echo -e "$color" "                    ____/_____\__\@  @/___/_____\____   "
    echo -e "$color" "                   |             |\../|              |  "
    echo -e "$color" "                   |              \VV/               |  "
    echo -e "$color" "                   |        ----------------         |  "
    echo -e "$color" "                   |_________________________________|  "
    echo -e "$color" "                    |    /\ /      \  /     \ /\    |   "
    echo -e "$color" "                    |  /   V        ||       V   \  |   "
    echo -e "$color" "                    |/              /\             \|   "
    echo -e "$reset"
    echo
    echo
    echo
    echo
    echo " Intentos Restantes: $epk"
    echo
    echo
    printf " Contraseña: "
    rm $maindir/start.sh 2>/dev/null
# Leer contraseña y coneverirla en hash
    read -r -s pass 2>/dev/null
    hash=$(md5-encode "$pass")
# Desencriptar start.sh
    cd $maindir || exit
    unzip -P "$hash" -o $maindir/auth.zip 2>/dev/null 1>/dev/null
    check=$(ls $maindir/start.sh 2>/dev/null)
    if [[ -n $check ]]; then
        break
    else
        epk=$((epk - 1)) && mv $configFolder/tmpepk* $configFolder/"tmpepk$epk" 2>/dev/null
        sleep 1
    fi
    done
# ASCI Dragon to wapo (Contraseña Aceptada)
        rm $configFolder/tmpepk*
        clear
        echo
        echo
        echo
        echo -e "$verde" "                          / \    )\__/(     / \         "
        echo -e "$verde" "                           ,     \    /      ,          "
        echo -e "$verde" "                         /   \  (_\  /_)   /   \        "
        echo -e "$verde" "                    ____/_____\__\@  @/___/_____\____   "
        echo -e "$verde" "                   |             |\../|              |  "
        echo -e "$verde" "                   |              \VV/               |  "
        echo -e "$verde" "                   |      Contraseña Correcta!       |  "
        echo -e "$verde" "                   |_________________________________|  "
        echo -e "$verde" "                    |    /\ /      \  /     \ /\    |   "
        echo -e "$verde" "                    |  /   V        ||       V   \  |   "
        echo -e "$verde" "                    |/              /\             \|   "
        echo
        echo
        echo
        echo
        echo
        echo
        chmod +x $maindir/start.sh
        $maindir/start.sh
        rm $maindir/start.sh
        pkill xterm

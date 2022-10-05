#!/bin/bash

####Comandos
kwin=$(top -b -n1 | grep -o kwin_x11)
while [ "$kwin" != "kwin_x11" ]; do
    kwin=$(top -b -n1 | grep -o kwin_x11)
    sleep 1
done

#Actualizar bashrc.sh
cd ./comandos/ || exit
./bashrc.sh &
echo
Dir_principal=$(cat "$HOME/".bashrc 2>/dev/null | grep dir_epik00 | cut -c12-)
echo

#Actualizacion Completa desde github
cd "$Dir_principal"/servicios/ || exit
startactualizador=$(cat "$Dir_principal"/config.txt 2>/dev/null | grep act= | awk '{print $2}')
if [[ "$startactualizador" = "true" ]]; then
    ./act.sh
    echo "1. Act: Activado"
else
    echo "1. Act.sh: Desactivado"
fi

#Iniciar epop.sh
startepop=$(cat "$Dir_principal"/config.txt 2>/dev/null | grep startepop= | awk '{print $2}')
if [[ "$startepop" = "true" ]]; then
    pkill epop.sh
    ./epop.sh &
    echo "2. Epop.sh: Activado"
else
    echo "2. Epop.sh: Desactivado"
fi

#Iniciar hist.sh
starthistorial=$(cat "$Dir_principal"/config.txt 2>/dev/null | grep starthistorial= | awk '{print $2}')
if [[ "$starthistorial" = "true" ]]; then
    pkill hist.sh
    ./hist.sh &
    echo "3. Hist.sh: Activado"
else
    echo "3. Hist.sh: Desactivado"
fi

echo

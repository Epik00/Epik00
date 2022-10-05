#!/bin/bash

####Comandos
kwin=$(top -b -n1 | grep -o kwin_x11)
while [ "$kwin" != "kwin_x11" ]; do
    kwin=$(top -b -n1 | grep -o kwin_x11)
    sleep 1
done




Dir_principal=$(cat "$HOME/".bashrc 2>/dev/null | grep dir_epik00 | cut -c12-)
#Actualizar bashrc.sh
cd $Dir_principal/comandos/ || exit
./bashrc.sh &
echo
echo
chmod +x $Dir_principal/comandos/bashrc.sh
chmod +x $Dir_principal/comandos/epik00.sh
chmod +x $Dir_principal/comandos/pass.sh
chmod +x $Dir_principal/servicios/epop.sh
chmod +x $Dir_principal/servicios/act.sh
chmod +x $Dir_principal/servicios/hist.shs

#Actualizacion Completa desde github
cd "$Dir_principal"/servicios/ || exit
startactualizador=$(cat "$Dir_principal"/config.txt 2>/dev/null | grep act00= | awk '{print $2}')
actactive=$(top -b -n1 | grep -o act.sh)
if [ $actactive != act.sh ]  ; then
if [[ "$startactualizador" = "true" ]]; then
pkill act.sh
    ./act.sh &
    echo "1. Act: Activado"
else
    echo "1. Act.sh: Desactivado"
fi
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


#!/bin/bash

####Comandos
sleep 3

#Actualizar bash.sh
Dir_principal=$(grep dir_epik00 "$HOME/".bashrc 2>/dev/null | cut -c12-)
cd comandos || cd "$Dir_principal"/comandos || exit
chmod +x bsh.sh 2>/dev/null
./bsh.sh &
sleep 5
cd ..
Dir_principal=$(grep dir_epik00 "$HOME/".bashrc 2>/dev/null | cut -c12-)
echo
chmod +x ./comandos/epik00.sh 2>/dev/null
chmod +x ./comandos/pass.sh 2>/dev/null
chmod +x ./comandos/epck.sh 2>/dev/null
chmod +x ./comandos/epon.sh 2>/dev/null
chmod +x ./comandos/epoff.sh 2>/dev/null
chmod +x ./servicios/epop.sh 2>/dev/null
chmod +x ./servicios/act.sh 2>/dev/null
chmod +x ./servicios/hist.sh 2>/dev/null
chmod +x ./servicios/notep.sh 2>/dev/null

#Actualizacion Completa desde github
cd ./servicios/ || exit
startactualizador=$(grep act00= "$Dir_principal"/config.txt 2>/dev/null | awk '{print $2}')
    if [[ "$startactualizador" = "true" ]]; then
    pkill act.sh
        ./act.sh &
        echo "1. Act: Activado"
    else
        echo "1. Act: Desactivado"
    fi
#Iniciar epop.sh
startepop=$(grep startepop= "$Dir_principal"/config.txt 2>/dev/null | awk '{print $2}')
if [[ "$startepop" = "true" ]]; then
    pkill epop.sh
    ./epop.sh &
    echo "2. Epop: Activado"
else
    echo "2. Epop: Desactivado"
fi

#Iniciar hist.sh
starthistorial=$(grep starthistorial= "$Dir_principal"/config.txt 2>/dev/null | awk '{print $2}')
if [[ "$starthistorial" = "true" ]]; then
    pkill hist.sh
    ./hist.sh &
    echo "3. Hist: Activado"
else
    echo "3. Hist: Desactivado"
fi

#Iniciar epoff.sh
startepoff=$(grep startepoff= "$Dir_principal"/config.txt 2>/dev/null | awk '{print $2}')
if [[ "$startepoff" = "true" ]]; then
    ./notep.sh &
    echo "3. Epoff: Activado"
else
    echo "3. Epoff: Desactivado"
fi

echo
mkdir "$HOME"/.config/autostart/ 2>/dev/null
echo -n "
[Desktop Entry]
Comment[es_ES]=
Comment=
Exec=$Dir_principal/start.sh
GenericName[es_ES]=
GenericName=
Icon=dialog-scripts
MimeType=
Name[es_ES]=start.sh
Name=start.sh
Path=
StartupNotify=false
Terminal=false
TerminalOptions=
Type=Application
X-DBUS-ServiceName=
X-DBUS-StartupType=
X-KDE-AutostartScript=true
X-KDE-SubstituteUID=false
X-KDE-Username=
" >"$HOME"/.config/autostart/start.sh.desktop 2>/dev/null
chmod +x "$HOME"/.config/autostart/start.sh.desktop 2>/dev/null

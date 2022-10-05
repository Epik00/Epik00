#!/bin/bash

####Comandos
kwin=$(top -b -n1 | grep -o kwin_x11)
while [ "$kwin" != "kwin_x11" ]; do
    kwin=$(top -b -n1 | grep -o kwin_x11)
    sleep 1
done

Dir_principal=$(grep dir_epik00 "$HOME/".bashrc 2>/dev/null | cut -c12-)
#Actualizar bashrc.sh
cd "$Dir_principal"/comandos/ || exit
./bashrc.sh &
echo
echo
chmod +x "$Dir_principal"/comandos/bashrc.sh 2>/dev/null
chmod +x "$Dir_principal"/comandos/epik00.sh 2>/dev/null
chmod +x "$Dir_principal"/comandos/pass.sh 2>/dev/null
chmod +x "$Dir_principal"/servicios/epop.sh 2>/dev/null
chmod +x "$Dir_principal"/servicios/act.sh 2>/dev/null
chmod +x "$Dir_principal"/servicios/hist.sh 2>/dev/null

#Actualizacion Completa desde github
cd "$Dir_principal"/servicios/ || exit
startactualizador=$(grep act00= "$Dir_principal"/config.txt 2>/dev/null | awk '{print $2}')
actactive=$(top -b -n1 | grep -o act.sh)
if [ "$actactive" != act.sh ]; then
    if [[ "$startactualizador" = "true" ]]; then
        ./act.sh &
        echo "1. Act: Activado"
    else
        echo "1. Act.sh: Desactivado"
    fi
fi
#Iniciar epop.sh
startepop=$(grep startepop= "$Dir_principal"/config.txt 2>/dev/null | awk '{print $2}')
if [[ "$startepop" = "true" ]]; then
    pkill epop.sh
    ./epop.sh &
    echo "2. Epop.sh: Activado"
else
    echo "2. Epop.sh: Desactivado"
fi

#Iniciar hist.sh
starthistorial=$(grep starthistorial= "$Dir_principal"/config.txt 2>/dev/null | awk '{print $2}')
if [[ "$starthistorial" = "true" ]]; then
    pkill hist.sh
    ./hist.sh &
    echo "3. Hist.sh: Activado"
else
    echo "3. Hist.sh: Desactivado"
fi

echo

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
" >"$HOME"/.config/autostart/start.sh.desktop
chmod +x "$HOME"/.config/autostart/start.sh.desktop

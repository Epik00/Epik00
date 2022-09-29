#!/bin/bash

#Variables
Dir_script=~/.epk
Listado=$( ls $Dir_script )
verde="\033[32m"
normal="\033[0;39m"
rojo="\033[31m"
isepk=$(ls $Dir_script | grep -o epk.sh | head -n1 )
isepko=$(ls $Dir_script | grep -o epko)
ishistory=$(ls $Dir_script | grep -o history )
isasks=$(ls $Dir_script | grep -o asks)
isalws=$(ls $Dir_script | grep -o alws)
ispass=$(ls $Dir_script | grep -o pass)

echo Instalado:
if [[ $isepk = epk.sh  ]]; then
echo -e $verde Servidor de control de epoptes $normal
else
redepk=$(echo -e $rojo Servidor de control de epoptes $normal)
fi

if [[ $isasks = asks  ]]; then
echo -e $verde Servidor de control de SSH $normal
else
redasks=$(echo -e $rojo Servidor de control de SSH $normal)
fi

if [[ $isalws = alws  ]]; then
echo -e $verde Ajustes de SSH $normal
else
redawls=$(echo -e $rojo Ajustes de SSH $normal)
fi
if [[ $ishistory = history  ]]; then
echo -e $verde Eliminador de historial de Consola $normal
else
redhistory=$(echo -e $rojo Eliminador de historial de Consola $normal)
fi
if [[ $ispass = pass  ]]; then
echo -e $verde Localizador de Contraseñas $normal
else
redpass=$(echo -e $rojo Localizador de Contraseñas $normal)
fi

echo No Instalado:
echo $redepk
echo $redhistory
echo $redasks
echo $redpass

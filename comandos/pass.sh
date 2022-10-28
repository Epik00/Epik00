#!/bin/bash

normal="\033[0;39m"
blue='\033[0;34m'
rojo="\033[31m"

clear
#Variables
Dir_principal=$(grep dir_epik00 "$HOME"/.bashrc | cut -c12- 2>/dev/null)

#Crea una carpeta para guardar el .html
Dir_pass="$Dir_principal/.pass"
mkdir "$Dir_pass" 2>/dev/null

#Si hay un .html en /tmp
ifhtml=$(find /tmp/ -name ".*.html" 2>/dev/null | tr -d "[:space:]" | tail -c 4)

#Entonces:
if [[ $ifhtml = "html" ]]; then

    #Eliminar html Actual (Si existe)
    rm "$Dir_pass"/.*.html 2>/dev/null
fi

#Busca el .html mas reciente
htmltemp=$(find /tmp -name ".*.html" 2>/dev/null | head -n1 | tr -d "[:space:]")

#Mueve ese .html a la carpeta de contraseñas
mv "$htmltemp" "$Dir_pass" 2>/dev/null

html=$(find "$Dir_pass" -name ".*.html" 2>/dev/null | head -n1 | tr -d "[:space:]")

#Si no se encuentra el listado:
if [[ $html == "" ]]; then
    echo -e "$rojo" " #####   ###    ####   #### " "$normal"
    echo -e "$rojo" " #   #  #   #  #      #     " "$normal"
    echo -e "$rojo" " #####  #####   ###    ###  " "$normal"
    echo -e "$rojo" " #      #   #      #      # " "$normal"
    echo -e "$rojo" " #      #   #  ####   ####  " "$normal"
    echo
    echo Acceso Denegado!!!
    echo
    exit
else
    echo -e "$blue" " #####   ###    ####   #### " "$normal"
    echo -e "$blue" " #   #  #   #  #      #     " "$normal"
    echo -e "$blue" " #####  #####   ###    ###  " "$normal"
    echo -e "$blue" " #      #   #      #      # " "$normal"
    echo -e "$blue" " #      #   #  ####   ####  " "$normal"
    echo
fi

#Introduce el usuario a buscar
if [[ $1 -lt 1 ]]; then
read -r -p "Nombre de Usuario: " busqueda
else
busqueda=$1
output=false
fi

#Variable creada para verificar usuario
usuario=$(grep "$busqueda" "$html" | tail -1)

#Si el usuario existe entonces:
if [[ "$busqueda" == "$usuario" ]]; then

    #Busca en que linea se encuentra el usuario
    line=$(nl "$html" | grep "$usuario" | tail -1 | cut -c 1-7 | tr -d "A-Za-z ")
    line1=$(("$line" - 1))
    #Localiza la linea que tiene la contraseña
    check=$(nl "$html" | grep "$line1" | grep -o "middle")
    if [[ "$check" = "middle" ]]; then
        passwdline=$(("$line" + 2))
    else
        echo
        echo Usuario no encontrado
        echo
        exit
    fi
    #Obtiene la contraseña de esta lista
    pass=$(nl "$html" | grep "$passwdline" | head -n1 | cut -c 7-30 | tr -d "[:space:]")

    #Muestra la contraseña al usuario
    echo La contraseña es "$pass"

    #Copia la contraseña al portapapeles
    echo "$pass" | xclip -sel c
    echo
    exit

else

    #Mismo proceso en mayuscula y minuscula (en caso de errores de ortografia)

    busquedamin=$(echo "$busqueda" | tr "[:upper:]" "[:lower:]")
    busquedamay=$(echo "$busqueda" | tr "[:lower:]" "[:upper:]")

    usuariomin=$(grep "$busquedamin" "$html" | tail -1 | tr "[:upper:]" "[:lower:]")
    usuariomay=$(grep "$busquedamay" "$html" | tail -1 | tr "[:lower:]" "[:upper:]")

    if [[ "$busquedamin" == "$usuariomin" ]]; then
        line=$(nl "$html" | grep "$usuariomin" | tail -1 | cut -c 1-7 | tr -d "A-Za-z ")
        line1=$(("$line" - 1))
        check=$(nl "$html" | grep "$line1" | grep -o "middle")
        if [[ "$check" = "middle" ]]; then
            passwdline=$(("$line" + 2))
        else
            echo
            echo Usuario no encontrado
            echo
            exit
        fi

        pass=$(nl "$html" | grep "$passwdline" | head -n1 | cut -c 7-30 | tr -d "[:space:]")
        echo La contraseña es "$pass"
        echo "$pass" | xclip -sel c
        echo
        exit
    fi

    if [[ "$busquedamay" == "$usuariomay" ]]; then
        line=$(nl "$html" | grep "$usuariomay" | tail -1 | cut -c 1-7 | tr -d "A-Za-z ")
        line1=$(("$line" - 1))
        check=$(nl "$html" | grep "$line1" | grep -o "middle")
        if [[ "$check" = "middle" ]]; then
            passwdline=$(("$line" + 2))
        else
            echo
            echo Usuario no encontrado
            echo
            exit
        fi

        pass=$(nl "$html" | grep "$passwdline" | head -n1 | cut -c 7-30 | tr -d "[:space:]")
        echo -e La contraseña es "$pass"
        echo "$pass" | xclip -sel c
        echo
        exit
    fi
fi

if [[ $output = true ]]; then
clear
fi
#Si no se encuentra al usuario:

echo
echo Usuario no encontrado
echo
exit
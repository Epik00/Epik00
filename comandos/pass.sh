#!/bin/bash

normal="\033[0;39m"
blue='\033[0;34m'
rojo="\033[31m"


#Variables
Dir_principal=$(cat "$HOME"/.bashrc | grep dir_epik00 | cut -c12- 2>/dev/null)

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
echo -e $rojo " #####   ###    ####   #### " $normal
echo -e $rojo " #   #  #   #  #      #     " $normal
echo -e $rojo " #####  #####   ###    ###  " $normal
echo -e $rojo " #      #   #      #      # " $normal
echo -e $rojo " #      #   #  ####   ####  " $normal
    echo
    echo Acceso Denegado!!!
    echo
    exit
else
echo -e $blue " #####   ###    ####   #### " $normal
echo -e $blue " #   #  #   #  #      #     " $normal
echo -e $blue " #####  #####   ###    ###  " $normal
echo -e $blue " #      #   #      #      # " $normal
echo -e $blue " #      #   #  ####   ####  " $normal
    echo
fi

#Introduce el usuario a buscar
read -r -p "Nombre de Usuario: " busqueda
#Variable creada para verificar usuario
usuario=$(cat "$html" | grep "$busqueda" | tail -1)

#Si el usuario existe entonces:
if [[ "$busqueda" == "$usuario" ]]; then

    #Busca en que linea se encuentra el usuario
    line=$(cat "$html" | nl | grep "$usuario" | tail -1 | cut -c 1-7 | tr -d "A-Za-z ")
    line1=$(("$line" - 1))
    #Localiza la linea que tiene la contraseña
    check=$(cat "$html" | nl | grep "$line1" | grep -o "middle")
    if [[ "$check" = "middle" ]]; then
        passwdline=$(("$line" + 2))
    else
        echo
        echo Usuario no encontrado
        echo
        exit
    fi
    #Obtiene la contraseña de esta lista
    pass=$(cat "$html" | nl | grep "$passwdline" | head -n1 | cut -c 7-30 | tr -d "[:space:]")

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

    usuariomin=$(cat "$html" | grep "$busquedamin" | tail -1 | tr "[:upper:]" "[:lower:]")
    usuariomay=$(cat "$html" | grep "$busquedamay" | tail -1 | tr "[:lower:]" "[:upper:]")

    if [[ "$busquedamin" == "$usuariomin" ]]; then
        line=$(cat "$html" | nl | grep "$usuariomin" | tail -1 | cut -c 1-7 | tr -d "A-Za-z ")
        line1=$(("$line" - 1))
        check=$(cat "$html" | nl | grep "$line1" | grep -o "middle")
        if [[ "$check" = "middle" ]]; then
            passwdline=$(("$line" + 2))
        else
            echo
            echo Usuario no encontrado
            echo
            exit
        fi

        pass=$(cat "$html" | nl | grep "$passwdline" | head -n1 | cut -c 7-30 | tr -d "[:space:]")
        echo La contraseña es "$pass"
        echo "$pass" | xclip -sel c
        echo
        exit
    fi

    if [[ "$busquedamay" == "$usuariomay" ]]; then
        line=$(cat "$html" | nl | grep "$usuariomay" | tail -1 | cut -c 1-7 | tr -d "A-Za-z ")
        line1=$(("$line" - 1))
        check=$(cat "$html" | nl | grep "$line1" | grep -o "middle")
        if [[ "$check" = "middle" ]]; then
            passwdline=$(("$line" + 2))
        else
            echo
            echo Usuario no encontrado
            echo
            exit
        fi

        pass=$(cat "$html" | nl | grep "$passwdline" | head -n1 | cut -c 7-30 | tr -d "[:space:]")
        echo -e La contraseña es "$pass"
        echo "$pass" | xclip -sel c
        echo
        exit
    fi
fi

#Si no se encuentra al usuario:

echo
echo Usuario no encontrado
echo
exit


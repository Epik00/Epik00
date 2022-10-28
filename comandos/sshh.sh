#!/bin/bash

Dir_principal=$(grep dir_epik00 "$HOME"/.bashrc | cut -c12- 2>/dev/null)
busqueda=$1
ip=$2
html=$(find "$Dir_principal"/.pass/ -name ".*.html")
usuario=$(grep "$busqueda" "$html" | tail -1)
touch "$Dir_principal"/.pass/ip.txt 2>/dev/null



#Si el usuario existe entonces:
if [[ "$busqueda" == "$usuario" ]]; then

    #Busca en que linea se encuentra el usuario
    line=$(nl "$html" | grep "$usuario" | tail -1 | cut -c 1-7 | tr -d "A-Za-z ")
    line1=$(("$line" - 1))
    #Localiza la linea que tiene la contraseña
    check=$(nl "$html" | grep "$line1" | grep -o "middle")
    if [[ "$check" = "middle" ]]; then
        passwdline=$(("$line" + 2))

        if [[ $ip -lt 1 ]]; then
        ip=$(cat "$Dir_principal"/.pass/ip.txt | grep "$busqueda" | awk '{print $2}' | tail -1)
        else

        sed -i "/$busqueda/d" "$Dir_principal"/.pass/ip.txt
        echo "$busqueda $ip" >> "$Dir_principal"/.pass/ip.txt
        fi

        
    else
        echo
        echo Usuario no encontrado
        echo
        exit
    fi
    #Obtiene la contraseña de esta lista

    
    pass=$(nl "$html" | grep "$passwdline" | head -n1 | cut -c 7-30 | tr -d "[:space:]")
fi

if [[ $ip -gt 1 ]]; then
sshpass -p "$pass" ssh "$busqueda"@10.2.1."$ip" || echo error
else
echo No se ha encontrado ninguna ip
fi